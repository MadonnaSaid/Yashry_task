<?php

//items class for array of objects
class Items
{
    public $Item_name;
    public $count;
    public $price_before_discount;
    public $price_after_discount;
    public $Item_Id;
    }
    
class Cart
{
	private $Item_ID;
	private $Item_type;
	private $Item_price;
	private $Weight;
    private $Country;
    private $Rate;
    public $cartItems = array();


	function __construct($Item_ID,$Item_type="",$Item_price="",$Weight="",$Country="",$Rate="")
	{
		$this->Item_ID = $Item_ID;
		$this->db = $this->connect();

		if(""===$Item_type)
		{
			$this->readCart($Item_ID);
		}
		else
		{
			$this->Item_type = $Item_type;
			$this->Item_price = $Item_price;
			$this->Weight = $Weight;
            $this->Country = $Country;
            $this->Rate = $Rate;

		}
	}

	function getItem_type()
	{
		return $this->Item_type;
	}	
	function setItem_type($Item_type)
	{
		return $this->Item_type = $Item_type;
	}

	function getItem_price()
	{
		return $this->Item_price;
	}
	function setItem_price($Item_price)
	{
		return $this->Item_price = $Item_price;
	}
	function getWeight()
	{
		return $this->Weight;
	}	
	function setWeight($Weight)
	{
		return $this->Weight = $Weight;
	}
    function getCountry()
    {
        return $this->Country;
    }
    function setCountry($Country)
    {
        return $this->Country = $Country;
    }
    function getRate()
    {
        return $this->Rate;
    }
    function setRate($Rate)
    {
        return $this->Rate = $Rate;
    }
    
	function getItem_ID()
	{
		return $this->Item_ID;
	}
  //Calculate the shipping
    function Shipping($Item_ID){
        $sql = "SELECT * FROM `Shipping_From` INNER JOIN `Items` ON Shipping_From.Item_ID = Items.Item_ID where Item_ID=".$Item_ID;
        $db = $this->connect();
        $result = $db->query($sql);
        if ($result->num_rows == 1){
            $row = $db->fetchRow();
            $Shipping = $row["Items.Weight"] * $row["Shipping_From.Rate"] * 10;
            return $Shipping;
    }
        }
  //calculate the VAT
    function VAT($Item_ID){
        $Item = "SELECT * FROM `Items` where Item_ID=".$Item_ID;
        $db = $this->connect();
        $result = $db->query($Item);
        if ($result->num_rows == 1){
            $row = $db->fetchRow();
            $VAT = $row["Item_price"] * 0.14;
            return $VAT;
    }
        }
  //checkout array of objects (items)
    function Checkout ($itemId){
        // check if item already exists if so increase the count of the item if not push into $Items
        $found = false;
        foreach ($cartItems as $item){
        if($item->Item_Id  == $itemId){
            $item->count ++;
            $found = true;
        }
    }
        if($found == false){
                $item1 = new Items();
                $item1 ->Item_Id = $itemId;
                $item1 ->count =1;
                $cartItems->push($item1);
            }
        }
    
    function Invoice(){
        //array of objects
        $total = 0;
        foreach($cartItems as $Item){
            $Items = "SELECT * FROM `Items` where Item_ID=".$Item_ID;
            $discount = "SELECT * FROM `Offers` where Item_ID=".$Item_ID;
            $db = $this->connect();
            $result = $db->query($Items);
            if ($result->num_rows == 1){
                $row = $db->fetchRow();
                //calculate subtotal
                //calculate same item by its count
                $Item->price_before_discount =  $row["Item_price"];
                $total +=  $Item->price_before_discount * $Item->count;
            }
            $result = $db->query($discount);
            if ($result->num_rows == 1){
                $row = $db->fetchRow();
                //offer1
                if($row["Item_ID"] != NULL){
                    $Total_Price =  $row["Items.Item_price"] * $row["Offers.Discount"] + $row["Items.Item_price"];
                }
                //offer2
                //check if count of array = count db
                //if true check if the jacket is available in the db
                //if true apply the discount in the db
                if($Item->count == $row["Count"]){
                if($Item->Item_Id == $row["AppliedDiscount_ItemID"]){
                    $Item->price_after_discount = $Item->price_before_discount - $row["Discount"];
                }
                    echo "The Jacket is not available in this offer";
                }
                //offer3
                if(count($cartItems) >= $row["Count"] ){
                    $Shipping = $this->Shipping($Item_ID) - 10;
                }
        }

    }
        }

}
    
    

