class DataMigration
  class << self
    def add_labels_v1
      labels = ["Lazada", "Shopee", "Amazon"]
      labels.each do |label|
        Label.find_or_create_by(content: label)
      end
    end

    def add_production_category
      options = {
        "Furniture": [
          "_default",
          "Sofas",
          "Bed frames",
          "Tables",
          "Seats",
          "Cabinets",
        ],
        "Lighting": [
          "_default",
          "Chandeliers",
          "Ceiling lights",
          "Floor lamps",
          "Wall lamps",
          "Table lamps",
          "Spotlights",
          "Pendant light",
        ],
        "Cooking & Dinning": [
          "_default",
          "Cooking",
          "Dinning",
        ],
        "Cleaning & Storage": [
          "_default",
          "Kitchen storage",
          "Bathroom storage",
          "Clothes storage",
          "Tabletop storage",
          "Wall storage",
          "Cleaning",
        ],
        "Soft": [
          "_default",
          "Rugs",
          "Cushions",
          "Beddings",
          "Curtains",
        ],
        "Decor": [
          "_default",
          "Paintings",
          "Aroma therapy",
          "Wall Decors",
          "Table decors",
          "Clocks",
          "Mirrors",
        ],
        "Forwarders": [
          "_default",
        ],
        "Others": [
          "_default",
        ],
      }

      options.each do |group_name, categories|
        categories.each do |category|
          if ProductCategory.find_by(group_name: group_name, name: category).nil?
            ProductCategory.create(group_name: group_name, name: category)
          end
        end
      end
    end

    def add_article_templates
      templates = [{
        name: "Test template",
        before_questions: {
          title: "please fill the form",
          questions: [{
            type: "input",
            title: "Its a input question",
          }, {
            type: "text",
            title: "Its a text question",
          }, {
            type: "rank",
            title: "Its a rank question",
          }, {
            type: "tag",
            title: "Its a tag question",
          }, {
            type: "select",
            title: "Its a select question",
            options: [{
              value: "option_1",
              label: "Option 1",
            }, {
              value: "option_2",
              label: "Option 2",
            }],
          }, {
            type: "multiple_select",
            title: "Its a multiple select question",
            options: [{
              value: "option_1",
              label: "Option 1",
            }, {
              value: "option_2",
              label: "Option 2",
            }],
          }],
        },
        after_questions: {
          title: "please fill the form",
          questions: [{
            type: "input",
            title: "Its a input question",
          }, {
            type: "text",
            title: "Its a text question",
          }, {
            type: "rank",
            title: "Its a rank question",
          }, {
            type: "tag",
            title: "Its a tag question",
          }, {
            type: "select",
            title: "Its a select question",
            options: [{
              value: "option_1",
              label: "Option 1",
            }, {
              value: "option_2",
              label: "Option 2",
            }],
          }, {
            type: "multiple_select",
            title: "Its a multiple select question",
            options: [{
              value: "option_1",
              label: "Option 1",
            }, {
              value: "option_2",
              label: "Option 2",
            }],
          }],
        },
      }]
      templates.each do |t|
        if !ArticleTemplate.exists?(name: t["name"])
          ArticleTemplate.create(t)
        end
      end
    end
  end
end
