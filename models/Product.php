<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "product".
 *
 * @property int $id_product
 * @property string $name
 * @property int $type_id
 * @property string $description
 * @property string $photo
 * @property int $cost
 * @property float $weight
 * @property string $created_at
 *
 * @property Cart[] $carts
 * @property Type $type
 */
class Product extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'product';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name', 'type_id', 'description', 'photo', 'cost', 'weight'], 'required'],
            [['type_id', 'cost'], 'integer'],
            [['description'], 'string'],
            [['weight'], 'number'],
            ['name', 'match', 'pattern' => '/^[а-яёА-ЯЁ\"\s]+$/iu', 'message'=>'Только кириллица, пробелы и "'],
            ['type_id', 'match', 'pattern' => '/^[0-9]+$/iu', 'message'=>'цифра'],
            ['cost', 'match', 'pattern' => '/^[\d]+$/iu', 'message'=>'Только цифры'],
           // ['photo', 'file', 'extensions' => 'jpg, jpeg, png', 'message' => 'Допустимые форматы: jpg, jpeg, png'],
            ['weight', 'match', 'pattern' => '/^[\d\.]+$/iu', 'message'=>'Точка, цифры'],
            [['created_at'], 'safe'],
            [['name'], 'string', 'max' => 100],
            [['photo'], 'string', 'max' => 255],
            [['type_id'], 'exist', 'skipOnError' => true, 'targetClass' => Type::class, 'targetAttribute' => ['type_id' => 'id_type']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id_product' => 'Id Product',
            'name' => 'Name',
            'type_id' => 'Type ID',
            'description' => 'Description',
            'photo' => 'Photo',
            'cost' => 'Cost',
            'weight' => 'Weight',
            'created_at' => 'Created At',
        ];
    }

    /**
     * Gets query for [[Carts]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getCarts()
    {
        return $this->hasMany(Cart::class, ['product_id' => 'id_product']);
    }

    /**
     * Gets query for [[Type]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getType()
    {
        return $this->hasOne(Type::class, ['id_type' => 'type_id']);
    }
}
