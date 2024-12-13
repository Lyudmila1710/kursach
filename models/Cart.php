<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "cart".
 *
 * @property int $id_cart
 * @property int $user_id
 * @property int $product_id
 * @property int $count
 * @property int|null $order_id
 *
 * @property Orders $order
 * @property Product $product
 * @property Users $user
 */
class Cart extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'cart';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['user_id', 'product_id', 'count'], 'required'],
            [['user_id', 'product_id', 'count', 'order_id'], 'integer'],
            ['count', 'match', 'pattern' => '/[0-9]+$/iu', 'message' =>'Только цифры'],
            [['product_id'], 'exist', 'skipOnError' => true, 'targetClass' => Product::class, 'targetAttribute' => ['product_id' => 'id_product']],
            [['user_id'], 'exist', 'skipOnError' => true, 'targetClass' => Users::class, 'targetAttribute' => ['user_id' => 'id_user']],
            [['order_id'], 'exist', 'skipOnError' => true, 'targetClass' => Orders::class, 'targetAttribute' => ['order_id' => 'id_order']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id_cart' => 'Id Cart',
            'user_id' => 'User ID',
            'product_id' => 'Product ID',
            'count' => 'Count',
            'order_id' => 'Order ID',
        ];
    }

    /**
     * Gets query for [[Order]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getOrder()
    {
        return $this->hasOne(Orders::class, ['id_order' => 'order_id']);
    }

    /**
     * Gets query for [[Product]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getProduct()
    {
        return $this->hasOne(Product::class, ['id_product' => 'product_id']);
    }

    /**
     * Gets query for [[User]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(Users::class, ['id_user' => 'user_id']);
    }
}
