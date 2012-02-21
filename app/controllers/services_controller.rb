# encoding: utf-8
class ServicesController < ApplicationController
  before_filter :authenticate_student!, :except => [:create]

def index
  # get all authentication services assigned to the current student
  @services = current_student.services.all
end

def destroy
  # remove an authentication service linked to the current student
  @service = current_student.services.find(params[:id])
  @service.destroy
      flash[:notice] = "Successfully destroyed authentication."
  redirect_to services_path
end

def create
  # get the service parameter from the Rails router
  params[:service] ? service_route = params[:service] : service_route = 'no service (invalid callback)'

  # get the full hash from omniauth
  omniauth = request.env["omniauth.auth"]

  # continue only if hash and parameter exist
  if omniauth and params[:service]

    # map the returned hashes to our variables first - the hashes differ for every service
    if service_route == 'facebook'
      omniauth['extra']['student_hash']['email'] ? email =  omniauth['extra']['student_hash']['email'] : email = ''
      omniauth['extra']['student_hash']['name'] ? name =  omniauth['extra']['student_hash']['name'] : name = ''
      omniauth['extra']['student_hash']['id'] ?  uid =  omniauth['extra']['student_hash']['id'] : uid = ''
      omniauth['provider'] ? provider =  omniauth['provider'] : provider = ''
    elsif service_route == 'github'
      omniauth['student_info']['email'] ? email =  omniauth['student_info']['email'] : email = ''
      omniauth['student_info']['name'] ? name =  omniauth['student_info']['name'] : name = ''
      omniauth['extra']['student_hash']['id'] ?  uid =  omniauth['extra']['student_hash']['id'] : uid = ''
      omniauth['provider'] ? provider =  omniauth['provider'] : provider = ''
    elsif service_route == 'twitter'
      email = ''    # Twitter API never returns the email address
      omniauth['student_info']['name'] ? name =  omniauth['student_info']['name'] : name = ''
      omniauth['uid'] ?  uid =  omniauth['uid'] : uid = ''
      omniauth['provider'] ? provider =  omniauth['provider'] : provider = ''
       elsif service_route == 'google'
       omniauth['student_info']['email'] ? email =  omniauth['student_info']['email'] : email = ''
       omniauth['student_info']['name'] ? name =  omniauth['student_info']['name'] : name = ''
       omniauth['uid'] ? uid =  omniauth['uid'] : uid = ''
       omniauth['provider'] ? provider =  omniauth['provider'] : provider = ''
    else
      # we have an unrecognized service, just output the hash that has been returned
      render :text => omniauth.to_yaml
      #render :text => uid.to_s + " - " + name + " - " + email + " - " + provider
      return
    end

    # continue only if provider and uid exist
    if uid != '' and provider != ''

      # nobody can sign in twice, nobody can sign up while being signed in (this saves a lot of trouble)
      if !student_signed_in?

        # check if student has already signed in using this service provider and continue with sign in process if yes
        auth = Service.find_by_provider_and_uid(provider, uid)
        if auth
          flash[:notice] = 'Η σύνδεση μέσω ' + provider.capitalize + ' έγινε με επιτυχία .'
          sign_in_and_redirect(:student, auth.student)
        else
          # check if this student is already registered with this email address; get out if no email has been provided
          if email != ''
            # search for a student with this email address
            existingstudent = Student.find_by_email(email)
            if existingstudent
              # map this new login method via a service provider to an existing account if the email address is the same
              existingstudent.services.create(:provider => provider, :uid => uid, :uname => name, :uemail => email)
              flash[:notice] = 'Η σύνδεση με ' + provider.capitalize + ' έχει προστεθεί στον λογαριασμό σας. ' + existingstudent.email + '. Signed in successfully!'
              sign_in_and_redirect(:student, existingstudent)
            else
              # let's create a new student: register this student and add this authentication method for this student
              name = name[0, 39] if name.length > 39             # otherwise our student validation will hit us

              # new student, set email, a random password and take the name from the authentication service
              student = Student.new :email => email, :password => SecureRandom.hex(10), :fullname => name, :haslocalpw => false

              # add this authentication service to our new student
              student.services.build(:provider => provider, :uid => uid, :uname => name, :uemail => email)

              # do not send confirmation email, we directly save and confirm the new record
              student.skip_confirmation!
              student.save!
              student.confirm!

              # flash and sign in
              flash[:myinfo] = 'Your account on CommunityGuides has been created via ' + provider.capitalize + '. In your profile you can change your personal information and add a local password.'
              sign_in_and_redirect(:student, student)
            end
          else
            flash[:error] =  service_route.capitalize + ' δεν μπορεί να χρησιμοποιηθεί για την εγγραφή σας στον χώρο συζήτησης και ενημέρωσης μιας και δεν παρέχεται κάποιο έγκυρο email. Παρακαλώ χρησιμοποιήστε άλλο πάροχο αυθεντικοποίησης ή χρησιμοποιήστε το σύστημα πιστοποίσης της παρούσας σελίδας. Εάν έχετε ήδη κάποιο λογαριασμό κάνετε είσοδο και προσθέστε το ' + service_route.capitalize + ' στο προφίλ σας.'
            redirect_to new_student_session_path
          end
        end
      else
        # the student is currently signed in

        # check if this service is already linked to his/her account, if not, add it
        auth = Service.find_by_provider_and_uid(provider, uid)
        if !auth
          current_student.services.create(:provider => provider, :uid => uid, :uname => name, :uemail => email)
          flash[:notice] = 'Η σύνδεση με ' + provider.capitalize + ' έχει προστεθεί στον λογαριασμό σας.'
          redirect_to services_path
        else
          flash[:notice] = service_route.capitalize + ' is already linked to your account.'
          redirect_to services_path
        end
      end
    else
      flash[:error] =  service_route.capitalize + ' επιστρέφει λανθασμένα δεδομένα για το id του φοιτητή.'
      redirect_to new_student_session_path
    end
  else
    flash[:error] = 'Σφάλμα κατά την αυθεντικοποίηση μέσω ' + service_route.capitalize + '.'
    redirect_to new_student_session_path
  end
end
end
