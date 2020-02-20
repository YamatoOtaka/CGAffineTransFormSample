# CGAffineTransFormSample

https://qiita.com/yum_fishing/items/2e8c3de5e110dbb9e41e より

CoreGraphicsのCGAffineTranaformを使った`回転`•`拡大/縮小`•`移動`•`せん断`のアニメーションサンプルのメモです。

# 回転


```.swift
    //ラジアン計算
    let angle = 180 * CGFloat.pi / 180
    //時計回りに180°
    let transform = CGAffineTransform(rotationAngle: angle)
    UIView.animate(withDuration: 1.0, animations: {
        self.animationView.transform = transform
    }) { _ in
        //元に戻す
        self.identity()
    }
```


# 拡大•縮小

## 拡大

```.swift
    // `1`がDefaultValue
    let transform = CGAffineTransform(scaleX: 2, y: 2)
    UIView.animate(withDuration: 1.0, animations: {
        self.animationView.transform = transform
    }) { _ in
        self.identity()
    }
```

## 縮小

```.swift
    let transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    UIView.animate(withDuration: 1.0, animations: {
        self.animationView.transform = transform
    }) { _ in
        self.identity()
    }
```



# 移動


```.swift
    let transform = CGAffineTransform(translationX: 100, y: 100)
    UIView.animate(withDuration: 1.0, animations: {
        self.animationView.transform = transform
    }) { _ in
        self.identity()
    }
```


# せん断

```.swift
    let transform = CGAffineTransform(a: 1, b: 0, c: 1, d: 1, tx: 0, ty: 0)
    UIView.animate(withDuration: 1.0, animations: {
        self.animationView.transform = transform
    }) { _ in
        self.identity()
    }
```


### メモ

CGAffineTranaformは`回転`・`拡大・縮小`・`移動`についてはそれぞれのコンストラクタがありますが、
せん断についてはアフィン変換行列から指定する必要があります。最後に指定方法をまとめます。


# アニメーションの原点を左上にしてみる

### Point

layerのアニメーションの原点は`anchorPoint`で変更することができます。ただ、`anchorPoint`を修正するとアニメーションの表示位置が意図通りにならないことがあるので、元のFrameにLayer.Frameを合わせることで正しい位置に表示するようにします。


## 回転

```.swift
    let angle = 180 * CGFloat.pi / 180
    let transform = CGAffineTransform(rotationAngle: angle)
    // anchorPointを変更しつつ、表示位置を変更させないための小技
    let tmpFrame = animationView.frame
    animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
    animationView.layer.frame = tmpFrame
    UIView.animate(withDuration: 1.0, animations: {
        self.animationView.transform = transform
    }) { _ in
        self.identity()
    }
```


## 拡大

```.swift
    let transform = CGAffineTransform(scaleX: 2, y: 2)
    let tmpFrame = animationView.frame
    animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
    animationView.layer.frame = tmpFrame
    UIView.animate(withDuration: 1.0, animations: {
        self.animationView.transform = transform
    }) { _ in
        self.identity()
    }
```


## 縮小

```.swift 
    let transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    let tmpFrame = animationView.frame
    animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
    animationView.layer.frame = tmpFrame
    UIView.animate(withDuration: 1.0, animations: {
        self.animationView.transform = transform
    }) { _ in
        self.identity()
    }
```


## 移動

```.swift
    let transform = CGAffineTransform(translationX: 100, y: 100)
    let tmpFrame = animationView.frame
    animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
    animationView.layer.frame = tmpFrame
    UIView.animate(withDuration: 1.0, animations: {
        self.animationView.transform = transform
    }) { _ in
        self.identity()
    }
```


## せん断

```.swift 
    let transform = CGAffineTransform(a: 1, b: 0, c: 1, d: 1, tx: 0, ty: 0)
    let tmpFrame = animationView.frame
    animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
    animationView.layer.frame = tmpFrame
    UIView.animate(withDuration: 1.0, animations: {
        self.animationView.transform = transform
    }) { _ in
        self.identity()
    }
```


# アニメーションを組み合わせてみる

### Point

CGAffineTransformをアニメーションとして組み合わせる場合は`transform`をセットするタイミングで連結することで上手くアニメーションが作動します。アニメーションをセットする前に`CGAffineTransform`を連結すると最初の`transform`のみ実行されるので注意が必要です。

## 回転&拡大

```.swift
    let tmpFrame = animationView.frame
    let angle = 180 * CGFloat.pi / 180
    let transform = CGAffineTransform(scaleX: 2, y: 2)
    let transform2 = CGAffineTransform(rotationAngle: angle)
    animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
    animationView.layer.frame = tmpFrame
    UIView.animate(withDuration: 1.0, animations: {
        // 組み合わせる時はtransformをセットするタイミングで連結しないとうまくいかない
        self.animationView.transform = transform.concatenating(transform2)
    }) { _ in
        self.identity()
    }
```



# アフィン変換について

swiftからは`回転`・`移動`・`拡大・縮小`などに関するアフィン変換についてはそれぞれラッパーとなるコンストラクタがありますが、`せん断`やカスタムでLayerを描画したい場合は下記の行列を指定して実装する必要があります。三列目は常に(0, 0, 1)などで実質データ構造としては最初の二列を指定します。

```math
\begin{bmatrix}
a & b & 0 \\
c & d & 0\\
tx & ty & 1
\end{bmatrix}

```

a, b, c, d, tx, ty それぞれの役割はこんな感じになり、tx・tyはそのままの意味で、それぞれ平行移動する距離をあらわします。

```math
\begin{bmatrix}
a & b & 0 \\
c & d & 0\\
tx & ty & 1
\end{bmatrix}

👉

\begin{bmatrix}
x.scale & y' & 0 \\
x' & y.scale & 0\\
tx & ty & 1
\end{bmatrix}


```

ちなみに何も指定していない場合のDefault値は以下になります。

```math
\begin{bmatrix}
a & b & 0 \\
c & d & 0\\
tx & ty & 1
\end{bmatrix}

👉

\begin{bmatrix}
1 & 0 & 0 \\
0 & 1 & 0\\
0 & 0 & 1
\end{bmatrix}


```

https://developer.apple.com/documentation/coregraphics/cgaffinetransform


## 行列を指定して実装してみる

### 拡大

```.swift
    // x, y とも２倍
    let transform = CGAffineTransform(a: 2, b: 0,
                                      c: 0, d: 2,
                                      tx: 0, ty: 0)
    UIView.animate(withDuration: 1.0, animations: {
        self.animationView.transform = transform
    }) { _ in
        self.identity()
    }
```

### 縮小

```.swift
    // x, y とも1/2倍
    let transform = CGAffineTransform(a: 0.5, b: 0,
                                      c: 0, d: 0.5,
                                      tx: 0, ty: 0)
    UIView.animate(withDuration: 1.0, animations: {
        self.animationView.transform = transform
    }) { _ in
        self.identity()
    }
```

## 移動

```.swift
     // x方向に100pt移動
     let transform = CGAffineTransform(a: 1, b: 0,
                                       c: 0, d: 1,
                                       tx: 100, ty: 0)
     UIView.animate(withDuration: 1.0, animations: {
         self.animationView.transform = transform
     }) { _ in
         self.identity()
     }
```

## せん断

せん断前のセクションで実装した通り下記のようになります。なお指定するCGFloatの移動距離は`x.scale * c`になります。今回は1を指定しているのでviewのframe.width分`xの正方向`に軸が傾きます。

```.swift
    // x.scale(width) * 1 軸が傾く
    let transform = CGAffineTransform(a: 1, b: 0,
                                      c: 1, d: 1,
                                      tx: 100, ty: 0)
    UIView.animate(withDuration: 1.0, animations: {
        self.animationView.transform = transform
    }) { _ in
        self.identity()
    }
```


## 回転

回転に関するアフィン変換は少し複雑で、それぞれ`x'`、`y'`を導き出す数式を知っていると上手く変換できます。回転の場合下記のようなアフィン変換で考えるとわかりやすい。

```math


\begin{bmatrix}
x' \\
y'  
\end{bmatrix}

👉

\begin{bmatrix}
cosθ & -sinθ \\
sinθ & cosθ
\end{bmatrix}

アフィン変換で表すと

\begin{bmatrix}
cosθ & sinθ & 0 \\
-sinθ & cosθ & 0\\
tx & ty & 1
\end{bmatrix}


```

数学的な見解が知りたい場合は[ここ](http://developer.wonderpla.net/entry/blog/engineer/CGAffineTrans)で説明してるサイトがわかりやすかったです。

```.swift
     // 90°時計回りに回転
     let angle = 90 * CGFloat.pi / 180
     let sinAngle = sin(angle)
     let cosAngle = cos(angle)
     let transform = CGAffineTransform(a: cosAngle, b: sinAngle,
                                          c: -sinAngle, d: cosAngle,
                                          tx: 0, ty: 0)
     UIView.animate(withDuration: 1.0, animations: {
         self.animationView.transform = transform
     }) { _ in
            self.identity()
     }
```
