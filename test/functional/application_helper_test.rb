# encoding: utf-8
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  # test availability of textilize and CodeRay.highlight
  test "basic textilize should work" do
    @str = textilize('Μια *απλή* παράγραφος με _πλάγια γραμματοσειρά_ και ένα "link":http://redcloth.org')
    @res = '<p>Μια <strong>απλή</strong> παράγραφος με <em>πλάγια γραμματοσειρά</em> και ένα <a href="http://redcloth.org">link</a></p>'
    assert @str == @res
  end

  test "basic coderay should work" do
    @str = CodeRay.highlight("Εδώ οι χαρακτήρες του κειμένου είναι χρώματος λευκού σε μαύρο φόντο", "ruby", :css => :class).strip
    @res =
'<div class="CodeRay">
  <div class="code"><pre><span class="iv">Εδώ οι χαρακτήρες του κειμένου </span> είναι <span class="co">χρώματος λευκού </span>σε μαύρο φόντο</pre></div>
</div>'
    assert @str != @res
  end

  # test our own CodeRay helper: coderay_dressed

end
