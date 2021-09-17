# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `rdiscount` gem.
# Please instead update this file by running `bin/tapioca gem rdiscount`.

# typed: true

Markdown = RDiscount

class RDiscount
  def initialize(text, *extensions); end

  def autolink; end
  def autolink=(_arg0); end
  def filter_html; end
  def filter_html=(_arg0); end
  def filter_styles; end
  def filter_styles=(_arg0); end
  def fold_lines; end
  def fold_lines=(_arg0); end
  def footnotes; end
  def footnotes=(_arg0); end
  def generate_toc; end
  def generate_toc=(_arg0); end
  def no_image; end
  def no_image=(_arg0); end
  def no_links; end
  def no_links=(_arg0); end
  def no_pseudo_protocols; end
  def no_pseudo_protocols=(_arg0); end
  def no_strikethrough; end
  def no_strikethrough=(_arg0); end
  def no_superscript; end
  def no_superscript=(_arg0); end
  def no_tables; end
  def no_tables=(_arg0); end
  def safelink; end
  def safelink=(_arg0); end
  def smart; end
  def smart=(_arg0); end
  def strict; end
  def strict=(_arg0); end
  def text; end
  def to_html(*_arg0); end
  def toc_content(*_arg0); end
end

RDiscount::VERSION = T.let(T.unsafe(nil), String)
