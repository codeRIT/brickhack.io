# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "jquery-datatables-rails"
  s.version = "3.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Robin Wenglewski"]
  s.date = "2015-04-06"
  s.description = ""
  s.email = ["robin@wenglewski.de"]
  s.files = ["app/assets", "app/assets/images", "app/assets/images/dataTables", "app/assets/images/dataTables/back_disabled.png", "app/assets/images/dataTables/back_enabled.png", "app/assets/images/dataTables/back_enabled_hover.png", "app/assets/images/dataTables/extras", "app/assets/images/dataTables/extras/background.png", "app/assets/images/dataTables/extras/button.png", "app/assets/images/dataTables/extras/collection.png", "app/assets/images/dataTables/extras/collection_hover.png", "app/assets/images/dataTables/extras/copy.png", "app/assets/images/dataTables/extras/copy_hover.png", "app/assets/images/dataTables/extras/csv.png", "app/assets/images/dataTables/extras/csv_hover.png", "app/assets/images/dataTables/extras/filler.png", "app/assets/images/dataTables/extras/insert.png", "app/assets/images/dataTables/extras/loading-background.png", "app/assets/images/dataTables/extras/pdf.png", "app/assets/images/dataTables/extras/pdf_hover.png", "app/assets/images/dataTables/extras/print.png", "app/assets/images/dataTables/extras/print_hover.png", "app/assets/images/dataTables/extras/xls.png", "app/assets/images/dataTables/extras/xls_hover.png", "app/assets/images/dataTables/favicon.ico", "app/assets/images/dataTables/forward_disabled.png", "app/assets/images/dataTables/forward_enabled.png", "app/assets/images/dataTables/forward_enabled_hover.png", "app/assets/images/dataTables/foundation", "app/assets/images/dataTables/foundation/sort_asc.png", "app/assets/images/dataTables/foundation/sort_asc_disabled.png", "app/assets/images/dataTables/foundation/sort_both.png", "app/assets/images/dataTables/foundation/sort_desc.png", "app/assets/images/dataTables/foundation/sort_desc_disabled.png", "app/assets/images/dataTables/minus.png", "app/assets/images/dataTables/plus.png", "app/assets/images/dataTables/sort_asc.png", "app/assets/images/dataTables/sort_asc_disabled.png", "app/assets/images/dataTables/sort_both.png", "app/assets/images/dataTables/sort_desc.png", "app/assets/images/dataTables/sort_desc_disabled.png", "app/assets/javascripts", "app/assets/javascripts/dataTables", "app/assets/javascripts/dataTables/bootstrap", "app/assets/javascripts/dataTables/bootstrap/2", "app/assets/javascripts/dataTables/bootstrap/2/jquery.dataTables.bootstrap.js", "app/assets/javascripts/dataTables/bootstrap/3", "app/assets/javascripts/dataTables/bootstrap/3/jquery.dataTables.bootstrap.js", "app/assets/javascripts/dataTables/extras", "app/assets/javascripts/dataTables/extras/dataTables.autoFill.js", "app/assets/javascripts/dataTables/extras/dataTables.colReorder.js", "app/assets/javascripts/dataTables/extras/dataTables.colVis.js", "app/assets/javascripts/dataTables/extras/dataTables.fixedColumns.js", "app/assets/javascripts/dataTables/extras/dataTables.fixedHeader.js", "app/assets/javascripts/dataTables/extras/dataTables.keyTable.js", "app/assets/javascripts/dataTables/extras/dataTables.responsive.js", "app/assets/javascripts/dataTables/extras/dataTables.scroller.js", "app/assets/javascripts/dataTables/extras/dataTables.tableTools.js", "app/assets/javascripts/dataTables/jquery.dataTables.api.fnFilterOnReturn.js", "app/assets/javascripts/dataTables/jquery.dataTables.api.fnGetColumnData.js", "app/assets/javascripts/dataTables/jquery.dataTables.api.fnReloadAjax.js", "app/assets/javascripts/dataTables/jquery.dataTables.api.fnSetFilteringDelay.js", "app/assets/javascripts/dataTables/jquery.dataTables.foundation.js", "app/assets/javascripts/dataTables/jquery.dataTables.js", "app/assets/javascripts/dataTables/jquery.dataTables.sorting.numbersHtml.js", "app/assets/javascripts/dataTables/jquery.dataTables.typeDetection.numbersHtml.js", "app/assets/media", "app/assets/media/dataTables", "app/assets/media/dataTables/extras", "app/assets/media/dataTables/extras/as3", "app/assets/media/dataTables/extras/as3/lib", "app/assets/media/dataTables/extras/as3/lib/AlivePDF.swc", "app/assets/media/dataTables/extras/as3/ZeroClipboard.as", "app/assets/media/dataTables/extras/as3/ZeroClipboardPdf.as", "app/assets/media/dataTables/extras/swf", "app/assets/media/dataTables/extras/swf/copy_csv_xls.swf", "app/assets/media/dataTables/extras/swf/copy_csv_xls_pdf.swf", "app/assets/stylesheets", "app/assets/stylesheets/dataTables", "app/assets/stylesheets/dataTables/bootstrap", "app/assets/stylesheets/dataTables/bootstrap/2", "app/assets/stylesheets/dataTables/bootstrap/2/jquery.dataTables.bootstrap.scss", "app/assets/stylesheets/dataTables/bootstrap/3", "app/assets/stylesheets/dataTables/bootstrap/3/jquery.dataTables.bootstrap.scss", "app/assets/stylesheets/dataTables/extras", "app/assets/stylesheets/dataTables/extras/dataTables.autoFill.scss", "app/assets/stylesheets/dataTables/extras/dataTables.colReorder.scss", "app/assets/stylesheets/dataTables/extras/dataTables.colvis.jqueryui.scss", "app/assets/stylesheets/dataTables/extras/dataTables.colVis.scss", "app/assets/stylesheets/dataTables/extras/dataTables.fixedColumns.scss", "app/assets/stylesheets/dataTables/extras/dataTables.fixedHeader.scss", "app/assets/stylesheets/dataTables/extras/dataTables.keyTable.scss", "app/assets/stylesheets/dataTables/extras/dataTables.responsive.scss", "app/assets/stylesheets/dataTables/extras/dataTables.scroller.scss", "app/assets/stylesheets/dataTables/extras/dataTables.tableTools.scss", "app/assets/stylesheets/dataTables/jquery.dataTables.foundation.scss", "app/assets/stylesheets/dataTables/jquery.dataTables.scss", "app/assets/stylesheets/dataTables/src", "app/assets/stylesheets/dataTables/src/demo_page.css", "app/assets/stylesheets/dataTables/src/demo_table.css", "app/assets/stylesheets/dataTables/src/demo_table_jui.css.scss", "app/assets/stylesheets/dataTables/src/jquery.dataTables_themeroller.css", "lib/generators", "lib/generators/jquery", "lib/generators/jquery/datatables", "lib/generators/jquery/datatables/install_generator.rb", "lib/jquery", "lib/jquery/datatables", "lib/jquery/datatables/rails", "lib/jquery/datatables/rails/engine.rb", "lib/jquery/datatables/rails/version.rb", "lib/jquery-datatables-rails.rb"]
  s.homepage = "https://github.com/rweng/jquery-datatables-rails"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "jquery datatables for rails"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
      s.add_runtime_dependency(%q<sass-rails>, [">= 0"])
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
      s.add_runtime_dependency(%q<actionpack>, [">= 3.1"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<sass-rails>, [">= 0"])
      s.add_dependency(%q<railties>, [">= 3.1"])
      s.add_dependency(%q<actionpack>, [">= 3.1"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<sass-rails>, [">= 0"])
    s.add_dependency(%q<railties>, [">= 3.1"])
    s.add_dependency(%q<actionpack>, [">= 3.1"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
