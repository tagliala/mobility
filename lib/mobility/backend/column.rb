module Mobility
  module Backend
=begin

Stores translated attribute as a column on the model table. To use this
backend, ensure that the model table has columns named +<attribute>_<locale>+
for every locale in +I18n.available_locales+.

If you are using Rails, you can use the +mobility:translations+ generator to
create a migration adding these columns to the model table with:

  rails generate mobility:translations post title:string

The generated migration will add columns +title_<locale>+ for every locale in
+I18n.available_locales+. (The generator can be run again to add new attributes
or locales.)

==Backend Options

There are no options for this backend. Also, the +locale_accessors+ option will
be ignored if set, since it would cause a conflict with column accessors.

@see Mobility::Backend::ActiveRecord::Column
@see Mobility::Backend::Sequel::Column

=end
    module Column
      extend OrmDelegator

      # Returns name of column where translated attribute is stored
      # @param [Symbol] locale
      # @return [String]
      def column(locale = Mobility.locale)
        Column.column_name_for(attribute, locale)
      end

      # Returns name of column where translated attribute is stored
      # @param [String] attribute
      # @param [Symbol] locale
      # @return [String]
      def self.column_name_for(attribute, locale = Mobility.locale)
        normalized_locale = Mobility.normalize_locale(locale)
        "#{attribute}_#{normalized_locale}".to_sym
      end

      def self.included(base)
        base.extend OrmDelegator
      end
    end
  end
end
