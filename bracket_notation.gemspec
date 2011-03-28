# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bracket_notation}
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cody Brimhall"]
  s.date = %q{2011-03-28}
  s.description = %q{Generates a representation of a syntax tree using a string of bracket notation.}
  s.email = %q{zbrimhall@gmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "COPYING", "README.rdoc", "lib/bracket_notation.rb", "lib/bracket_notation/evaluator.rb", "lib/bracket_notation/expressions.rb", "lib/bracket_notation/expressions/expression.rb", "lib/bracket_notation/expressions/identifier.rb", "lib/bracket_notation/expressions/terminal.rb", "lib/bracket_notation/geometry.rb", "lib/bracket_notation/geometry/point.rb", "lib/bracket_notation/geometry/rect.rb", "lib/bracket_notation/geometry/size.rb", "lib/bracket_notation/parser.rb", "lib/bracket_notation/scanner.rb", "lib/bracket_notation/token.rb", "lib/bracket_notation/version.rb", "lib/bracket_notation/views.rb", "lib/bracket_notation/views/branch.rb", "lib/bracket_notation/views/leaf.rb", "lib/bracket_notation/views/node.rb", "lib/bracket_notation/views/tree.rb"]
  s.files = ["CHANGELOG", "COPYING", "README.rdoc", "Rakefile", "init.rb", "lib/bracket_notation.rb", "lib/bracket_notation/evaluator.rb", "lib/bracket_notation/expressions.rb", "lib/bracket_notation/expressions/expression.rb", "lib/bracket_notation/expressions/identifier.rb", "lib/bracket_notation/expressions/terminal.rb", "lib/bracket_notation/geometry.rb", "lib/bracket_notation/geometry/point.rb", "lib/bracket_notation/geometry/rect.rb", "lib/bracket_notation/geometry/size.rb", "lib/bracket_notation/parser.rb", "lib/bracket_notation/scanner.rb", "lib/bracket_notation/token.rb", "lib/bracket_notation/version.rb", "lib/bracket_notation/views.rb", "lib/bracket_notation/views/branch.rb", "lib/bracket_notation/views/leaf.rb", "lib/bracket_notation/views/node.rb", "lib/bracket_notation/views/tree.rb", "test/functional/evaluator_test.rb", "test/functional/node_test.rb", "test/functional/parser_test.rb", "test/functional/scanner_test.rb", "test/functional/tree_test.rb", "test/integration/layout_test.rb", "test/integration/parsing_test.rb", "test/test_helper.rb", "test/unit/expression_test.rb", "test/unit/point_test.rb", "test/unit/rect_test.rb", "test/unit/size_test.rb", "test/unit/token_test.rb", "Manifest", "bracket_notation.gemspec"]
  s.homepage = %q{http://github.com/zbrimhall/bracket_notation}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Bracket_notation", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{bracket_notation}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Provides a parser for strings that have been marked up with the bracket notation commonly used by syntacticians. The parser generates an abstract tree representation of the syntax of the string.}
  s.test_files = ["test/functional/evaluator_test.rb", "test/functional/node_test.rb", "test/functional/parser_test.rb", "test/functional/scanner_test.rb", "test/functional/tree_test.rb", "test/integration/layout_test.rb", "test/integration/parsing_test.rb", "test/test_helper.rb", "test/unit/expression_test.rb", "test/unit/point_test.rb", "test/unit/rect_test.rb", "test/unit/size_test.rb", "test/unit/token_test.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rmagick>, [">= 2.13.1"])
      s.add_development_dependency(%q<shoulda>, [">= 2.11.3"])
    else
      s.add_dependency(%q<rmagick>, [">= 2.13.1"])
      s.add_dependency(%q<shoulda>, [">= 2.11.3"])
    end
  else
    s.add_dependency(%q<rmagick>, [">= 2.13.1"])
    s.add_dependency(%q<shoulda>, [">= 2.11.3"])
  end
end
