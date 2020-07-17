Genre.create!(
  [
    {
      name: "和食"
    },
    {
      name: "洋食"
    },
    {
      name: "中華料理"
    },
    {
      name: "韓国料理"
    },
    {
      name: "その他"
    }
  ]
  )

Type.create!(
  [
    {
      name: "ご飯・麺・パン"
    },
    {
      name: "主菜"
    },
    {
      name: "副菜"
    },
    {
      name: "丼"
    },
    {
      name: "汁物・スープ"
    },
    {
      name: "お菓子・デサート"
    },
    {
      name: "その他"
    }
  ]
  )

Tag.create!(
  [
    {
      name: "高タンパク"
    },
    {
      name: "ヘルシー"
    },
    {
      name: "スタミナ"
    },
    {
      name: "爽やか"
    },
    {
      name: "夏ランチ"
    },
    {
      name: "おつまみ"
    }
  ]
  )

User.create!(
  [
    {
      email: "1@1",
      name: "マイケル",
      introduction: "料理するのが大好きです",
      image: File.open("./app/assets/images/profile_image1.jpg"),
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "2@2",
      name: "ローランド",
      introduction: "最近料理始めました",
      image: File.open("./app/assets/images/profile_image2.jpg"),
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "3@3",
      name: "レアード",
      introduction: "料理初心者ですがよろしくお願いします",
      image: File.open("./app/assets/images/profile_image3.jpg"),
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "4@4",
      name: "杉谷",
      introduction: "元料理人です。よろしくお願いします",
      image: File.open("./app/assets/images/profile_image4.jpg"),
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "5@5",
      name: "ダルビッシュ",
      introduction: "元料理人です。よろしくお願いします",
      image: File.open("./app/assets/images/profile_image5.jpg"),
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "6@6",
      name: "ネイマール",
      introduction: "中華料理が好きです。よろしくお願いします",
      image: File.open("./app/assets/images/profile_image6.jpg"),
      password: "password",
      password_confirmation: "password"
    }
  ]
  )
reci1 = "1.今回は「キユーピー マヨネーズ」を使います。"
reci2 = "2.キャベツは4cm角に切る。鶏むね肉はひと口大のそぎ切りにする。"
reci3 = "3.フライパンにマヨネーズ大さじ1を入れて中火にかけ、マヨネーズが溶けはじめたら鶏むね肉を加え、火が通るまで炒める。"
reci4 = "4.残りのマヨネーズとみそを混ぜたものを加え、全体になじませたらキャベツを入れ、炒め合わせる。"
reci5 = "5.炒めた具材をフライパンの端に寄せ、空いたスペースに溶いた卵を流し入れ、半熟状にする。"
reci6 = "6.具材と卵をさっと炒め合わせる。"

for i in 1..15 do
  Recipe.create!(
    [
      {
        user_id: rand(1..6),
        title: "レシピタイトル#{i}",
        body: "料理紹介文おいしくて\n簡単なレシピです",
        price: rand(2..5) * 100,
        quantity: rand(1..4),
        material: "材料名#{i}\nにんじん　１個\nささみ　１個\n醤油　大さじ１\nキャベツ　１個",
        make: "作り方#{i}\n#{reci1}\n#{reci2}\n#{reci3}\n#{reci4}\n#{reci5}\n#{reci6} ",
        image: File.open("./app/assets/images/recipe_image#{i}.jpg"),
        genre_id: rand(1..5),
        type_id: rand(1..7)
      }
    ]
    )
end

for i in 1..15 do
  RecipeTag.create!(
    [
      {
        tag_id: rand(1..3),
        recipe_id: i
      }
    ]
    )
end

for i in 7..15 do
  User.create!(
    [
      {
        email: "#{i}@#{i}",
        name: "テスト#{i}",
        introduction: "中華料理が好きです。よろしくお願いします",
        image: File.open("./app/assets/images/profile_image#{i}.jpg"),
        password: "password",
        password_confirmation: "password"
      }
    ]
    )
end

for i in 1..15 do
  Like.create!(
    [
      {
        user_id: i,
        recipe_id: rand(1..5)
      },
      {
        user_id: i,
        recipe_id: rand(6..10)
      },
      {
        user_id: i,
        recipe_id: rand(11..15)
      }
    ]
    )
end

for i in 1..15 do
  Comment.create!(
    [
      {
        user_id: i,
        recipe_id: rand(1..5),
        comment: "とても美味しかったです#{i}"
      },
      {
        user_id: i,
        recipe_id: rand(6..10),
        comment: "簡単に出来ました#{i}"
      },
      {
        user_id: i,
        recipe_id: rand(11..15),
        comment: "また作ります！#{i}"
      }
    ]
    )
end

for i in 1..15 do
  Relationship.create!(
    [
      {
        follower_id: i,
        followed_id: rand(1..3)
      },
      {
        follower_id: i,
        followed_id: rand(4..6)
      },
      {
        follower_id: i,
        followed_id: rand(7..9)
      },
      {
        follower_id: i,
        followed_id: rand(10..12)
      },
      {
        follower_id: i,
        followed_id: rand(13..15)
      }
    ]
    )
end

