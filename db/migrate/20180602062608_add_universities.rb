class AddUniversities < ActiveRecord::Migration[5.1]
  def change
    University.where(name_en: "Boston College", name_cn: "波士顿学院").first_or_create

    University.where(name_en: "Brandeis University", name_cn: "布兰迪斯大学").first_or_create

    University.where(name_en: "Brown University", name_cn: "布朗大学").first_or_create

    University.where(name_en: "Case Western Reserve University", name_cn: "凯斯西储大学").first_or_create

    University.where(name_en: "California Institute of Technology", name_cn: "加州理工学院").first_or_create
    University.where(name_en: "Carnegie Mellon University", name_cn: "卡内基美隆大学").first_or_create
    University.where(name_en: "College of William and Mary", name_cn: "威廉玛丽学院").first_or_create
    University.where(name_en: "Columbia University", name_cn: "哥伦比亚大学").first_or_create


    University.where(name_en: "Cornell University", name_cn: "康奈尔大学").first_or_create

    University.where(name_en: "Dartmouth College", name_cn: "达特茅斯学院").first_or_create

    University.where(name_en: "Duke University", name_cn: "杜克大学").first_or_create

    University.where(name_en: "Emory University", name_cn: "埃默里大学").first_or_create
    University.where(name_en: "Georgetown University", name_cn: "乔治城大学").first_or_create

    University.where(name_en: "Georgia Institute of Technology", name_cn: "佐治亚理工学院").first_or_create

    University.where(name_en: " Harvard University", name_cn: "哈佛大学").first_or_create

    University.where(name_en: "Johns Hopkins University", name_cn: "约翰霍普金斯大学").first_or_create

    University.where(name_en: "Lehigh University", name_cn: "理海大学").first_or_create

    University.where(name_en: "Massachusetts Institute of Technology", name_cn: "麻省理工学院").first_or_create

    University.where(name_en: "New York University", name_cn: "纽约大学").first_or_create

    University.where(name_en: "Northeastern University", name_cn: "东北大学").first_or_create

    University.where(name_en: "Northwestern University", name_cn: "西北大学").first_or_create
    University.where(name_en: "Princeton University", name_cn: "普林斯顿大学").first_or_create
    University.where(name_en: "Rice University", name_cn: "莱斯大学").first_or_create
    University.where(name_en: "Stanford University", name_cn: "斯坦福大学").first_or_create

    University.where(name_en: "Tufts University", name_cn: "塔夫茨大学").first_or_create

    University.where(name_en: "Tulane University", name_cn: "杜兰大学").first_or_create

    University.where(name_en: "UC Berkeley", name_cn: "加州大学伯克利分校").first_or_create

    University.where(name_en: "University of California-Davis", name_cn: "加州大学戴维斯分校").first_or_create
    University.where(name_en: "UCLA", name_cn: "加州大学洛杉矶分校").first_or_create

    University.where(name_en: "University of California-Irvine", name_cn: "加州大学欧文分校").first_or_create

    University.where(name_en: "University of California-Santa Barbara", name_cn: "加州大学圣塔芭芭拉分校").first_or_create

    University.where(name_en: "University of California-San Diego", name_cn: "加州大学圣地亚哥分校").first_or_create
    University.where(name_en: "University of Chicago", name_cn: "芝加哥大学").first_or_create

    University.where(name_en: "University of Florida", name_cn: "佛罗里达大学").first_or_create

    University.where(name_en: "University of Maryland-College Park:", name_cn: "马里兰大学帕克分校").first_or_create
    University.where(name_en: "University of Miami", name_cn: "迈阿密大学").first_or_create
    University.where(name_en: "University of North Carolina-Chapel Hill", name_cn: "北卡罗来纳大学教堂山分校").first_or_create
    University.where(name_en: "University of Notre Dame", name_cn: "圣母大学").first_or_create


    University.where(name_en: "University of Pennsylvania", name_cn: "宾夕法尼亚大学").first_or_create
    University.where(name_en: "University of Pittsburgh", name_cn: "匹兹堡大学").first_or_create

    University.where(name_en: "University of Rochester", name_cn: "罗切斯特大学").first_or_create

    University.where(name_en: "University of Southern California", name_cn: "南加州大学").first_or_create
    University.where(name_en: "University of Texas-Austin", name_cn: "德州大学奥斯汀分校").first_or_create


    University.where(name_en: "University of Virginia", name_cn: "弗吉尼亚大学").first_or_create
    University.where(name_en: "University of Washington at Seattle", name_cn: "华盛顿大学西雅图分校").first_or_create

    University.where(name_en: "University of illinois Urbana-Champaign", name_cn: "伊利诺伊大学香槟分校").first_or_create

    University.where(name_en: "University of Wisconsin-Madison", name_cn: "威斯康辛大学麦迪逊分校").first_or_create

    University.where(name_en: "Vanderbilt University", name_cn: "范德堡大学").first_or_create


    University.where(name_en: "Wake Forest University", name_cn: "维克森林大学").first_or_create
    University.where(name_en: "Washington University in St.Louis", name_cn: "圣路易斯华盛顿大学").first_or_create
    University.where(name_en: "Yale University", name_cn: "耶鲁大学").first_or_create

  end
end
