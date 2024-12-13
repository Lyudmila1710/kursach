<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "orders".
 *
 * @property int $id_order
 * @property string $phone
 * @property string $address
 * @property string $date_delivery
 * @property string $payment
 * @property string $comments
 * @property string $date_create
 *
 * @property Cart[] $carts
 */
class Orders extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'orders';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['phone', 'address', 'date_delivery'], 'required'],
            [['date_delivery', 'date_create'], 'safe'],
            [['payment', 'comments'], 'string'],
            [['phone'], 'string', 'max' => 20],
            [['address'], 'string', 'max' => 100],
            ['phone', 'match', 'pattern' => '/^(\+)[\d]+$/iu', 'message'=>'Только цифры и +, в виде +79348544858'],
            ['address', 'match', 'pattern' => '/^[а-яёА-ЯЁ\-\s\.\,\d]+$/iu', 'message'=>'Кириллица, дефис, запятая, точка, пробел'],
            ['payment', 'match', 'pattern' => '/^[а-я\s]+$/iu', 'message'=>'наличными или банковской картой'],
            ['date_delivery', 'match', 'pattern' => '/^\d{4}\-\d{1,2}\-\d{1,2}+$/iu', 'message'=>'в формате 2024-12-20'],
            
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id_order' => 'Id Order',
            'phone' => 'Phone',
            'address' => 'Address',
            'date_delivery' => 'Date Delivery',
            'payment' => 'Payment',
            'comments' => 'Comments',
            'date_create' => 'Date Create',
        ];
    }

    /**
     * Gets query for [[Carts]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getCarts()
    {
        return $this->hasMany(Cart::class, ['order_id' => 'id_order']);
    }
}
