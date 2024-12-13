<?php
namespace app\controllers;
use app\models\Product;
use Yii;
use app\models\Users;
use yii\web\UploadedFile;
class ProductController extends FunctionController
{
 public $modelClass = 'app\models\Product';

    public function actionView() {
        $products = Product::find()->all();
        
        if (empty($products)) {
            return $this->send(404, [
                'error' => [
                    'code' => 404,
                    'message' => 'Products not found'
                ]
            ]);
        }
        $productList = [];
        foreach ($products as $product) {
            $productList[] = [
                'id' => $product->id_product,
                'name' => $product->name,
                'type' => $product->type->name,
                'description' => $product->description,
                'photo' => $product->photo, 
                'created_at' => $product->created_at,
                'cost' => $product->cost,
                'weight' => $product->weight,
            ];
        }
    
        // Возврат успешного ответа с данными о продуктах
        return $this->send(200, [
            'data' => [
                'products' => $productList
            ]
        ]);
    }

    public function actionSearch()
{
    $queryP = Yii::$app->request->get('type');
     // Выполняем поиск по товарам
     $products = Product::find()->joinWith('type')->where(['like', 'type.name', $queryP])->all() ;
 if (empty($products)) {
     return $this->send(404, [
         'error' => [
             'code' => 404,
             'message' => 'Product not found'
         ]
     ]);
 }

 // Формируем ответ
 $result = [];
 foreach ($products as $product) {
     $result[] = [
         'id' => $product->id_product,
         'name' => $product->name,
         'type' => $product->type->name, // Получаем название типа
         'description' => $product->description,
         'photo' => $product->photo,
         'date_create' => $product->created_at,
         'cost' => $product->cost,
         'weight' => $product->weight,
     ];
 }

 return $this->send(200, [
     'data' => [
         'products' => $result
     ]
 ]);
}

public function actionCreate()
{
    $user = Users::getToken();
    $post_data=\Yii::$app->request->post();
    if (!($user && $user->isAuthorized() && $user->isAdmin())) {
       return $this->send(403, ['error' => ['message' => 'Forbidden']]);
   }
   $post_data=\Yii::$app->request->post();
   $product=new Product();
   $product->load($post_data, '');
   $product->photo=UploadedFile::getInstanceByName('photo');
   
   if ($product->photo) { $hash=hash('sha256', $product->photo->baseName) . '.' . $product -> photo->extension;
    $product->photo->saveAs(\Yii::$app->basePath. '/api/assets/upload/' . $hash);
    $product->photo=$hash;}else {
        return $this->send(400, ['error' => ['message' => 'Файл не загружен или такая фотография уже есть']]);
    }
    if (!$product->validate()) return $this->validation($product);
    $product->save(false);
    return $this->send(200,[
        'data' => [
            'status' => 'ok',
            'id' => $product->id_product,

        ],
    ]);
}

public function actionEdit()
{
    $id_product = Yii::$app->request->get('id_product');
        $user = Users::getToken();
        if (!($user && $user->isAuthorized() && $user->isAdmin())) {
            return $this->send(403, ['error' => ['message' => 'Forbidden']]);
        }
            $data = Yii::$app->request->post();
            $product = Product::findOne($id_product);
            if (!$product) {
                return $this->send(404, [
                    'error' => [
                        'code' => 404,
                        'message' => 'Product not found'
                    ]
                ]);
            }
            if (isset($data['name'])) {
                $product->name = $data['name'];
            }
            
            if (isset($data['type_id'])) {
                $product->type_id = $data['type_id'];
            }
        
            if (isset($data['cost'])) {
                $product->cost = $data['cost'];
            }
        
            if (isset($data['description'])) {
                $product->description = $data['description'];
            }
            if ($product->validate() && $product->save()) {
                return $this->send(200, [
                    'data' => [
                        'status' => 'ok'
                        
                    ]
                ]);
            }
            return $this->validation($product);
}
}
