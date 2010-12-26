# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bracket_notation}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cody Brimhall"]
  s.date = %q{2010-12-26}
  s.description = %q{Generate a representation of a syntax tree using a string of bracket notation.}
  s.email = %q{zbrimhall@gmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "COPYING", "README.rdoc", "lib/bracket_notation.rb", "lib/bracket_notation/evaluator.rb", "lib/bracket_notation/expressions.rb", "lib/bracket_notation/expressions/expression.rb", "lib/bracket_notation/expressions/identifier.rb", "lib/bracket_notation/expressions/terminal.rb", "lib/bracket_notation/parser.rb", "lib/bracket_notation/scanner.rb", "lib/bracket_notation/token.rb", "lib/bracket_notation/version.rb"]
  s.files = ["CHANGELOG", "COPYING", "Manifest", "README.rdoc", "Rakefile", "bracket_notation.gemspec", "init.rb", "lib/bracket_notation.rb", "lib/bracket_notation/evaluator.rb", "lib/bracket_notation/expressions.rb", "lib/bracket_notation/expressions/expression.rb", "lib/bracket_notation/expressions/identifier.rb", "lib/bracket_notation/expressions/terminal.rb", "lib/bracket_notation/parser.rb", "lib/bracket_notation/scanner.rb", "lib/bracket_notation/token.rb", "lib/bracket_notation/version.rb", "test/functional/evaluator_test.rb", "test/functional/parser_test.rb", "test/functional/scanner_test.rb", "test/integration/parsing_test.rb", "test/test_helper.rb", "test/unit/expression_test.rb", "test/unit/token_test.rb"]
  s.homepage = %q{http://github.com/zbrimhall/bracket_notation}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Bracket_notation", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{bracket_notation}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Generate a representation of a syntax tree using a string of bracket notation.}
  s.test_files = ["test/functional/evaluator_test.rb", "test/functional/parser_test.rb", "test/functional/scanner_test.rb", "test/integration/parsing_test.rb", "test/test_helper.rb", "test/unit/expression_test.rb", "test/unit/token_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
