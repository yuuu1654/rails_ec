# frozen_string_literal: true

# product = Product.create!(
#     name: "アマゾナイト",
#     price: 1800,
#     description: "綺麗なアマゾナイトです"
# )

# # サンプル画像のパスを取得
# image_path = Rails.root.join("app/assets/images", "アマゾナイト.png")

# # Active Storage を使用して画像を添付
# product.image.attach(io: File.open(image_path), filename: "アマゾナイト.png", content_type: "image/png")

products_data = [
  { name: 'アマゾナイト',
    price: 2480,
    description: 'モザンビーク産アマゾナイトのペンダントトップです。 鮮やかなブルーグリーンのベースに原石由来の白い模様が特徴です。',
    image_name: 'アマゾナイト.png' },
  { name: 'ハックマナイト',
    price: 1680,
    description: 'パキスタン産ハックマナイトのペンダントトップです。 ハックマナイトはソーダライトの変種で、方ソーダ石の構成成分に含まれる硫黄成分が紫外線を吸収して薄い紫や、濃い紫、ピンクや赤などに変色する性質を持ち、コレクターも多い石です。',
    image_name: 'ハックマナイト.png' },
  { name: 'ピンクオパールコッパーターコイズ',
    price: 2500,
    description: 'ピンクオパールコッパーターコイズのペンダントトップです。 ターコイズの鮮やかなブルーとピンクオパールの可憐なピンクをベースにコッパー（銅）のゴールドの輝きが映えています。',
    image_name: 'ピンクオパールコッパーターコイズ.png' },
  { name: 'ブラックオパール',
    price: 2480,
    description: 'エチオピア産ブラックオパールです。 夜空に浮かぶオーロラのような美しい遊色効果が見られるお品です。',
    image_name: 'ブラックオパール.png' },
  { name: 'ブルーカラーアンバー琥珀',
    price: 2800,
    description: 'ポーランド産ブルーカラーアンバーのペンダントトップです。透明感がありブルー～クリアのグラデーションがとても綺麗です。 天然の琥珀に色加工を施し、この鮮やかな色合いに仕上げています。',
    image_name: 'ブルーカラーアンバー琥珀.png' },
  { name: 'ペリドット',
    price: 2200,
    description: '中国産ペリドットのカット入りペンダントトップです。透明度が高く発色も良く、両面にカットが入っておりシンプルな枠がカットの輝きをより引き立てています。',
    image_name: 'ペリドット.png' },
  { name: 'ラリマー',
    price: 1980,
    description: 'カリブ海が世界に誇る希少な天然石、ドミニカ産ラリマーのペンダントトップです。 鮮やかなブルーのベースにラリマー特有の波模様が見られる高品質なお品です。 石の美しさが際立つシンプルなデザインで仕上げられています。',
    image_name: 'ラリマー.png' },
  { name: 'ルビー',
    price: 2480,
    description: 'ミャンマー産ルビーのペンダントトップです。 深みのあるレッドの色合いが重厚感と気品を感じさせる素敵なお品です。',
    image_name: 'ルビー.png' }
]

products_data.each do |data|
  product = Product.create!(
    name: data[:name],
    price: data[:price],
    description: data[:description]
  )

  # サンプル画像のパスを取得
  image_path = Rails.root.join('app/assets/images', data[:image_name])

  # Active Storage を使用して画像を添付
  product.image.attach(io: File.open(image_path), filename: data[:image_name], content_type: 'image/png')
end
