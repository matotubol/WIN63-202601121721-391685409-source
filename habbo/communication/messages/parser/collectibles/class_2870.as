package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2870
   {
      
      protected var var_3908:int;
      
      protected var var_4497:String;
      
      protected var var_808:int;
      
      protected var _petFigureString:String;
      
      protected var var_3127:Vector.<int>;
      
      protected var var_2711:String;
      
      protected var var_3946:String;
      
      public function class_2870(param1:IMessageDataWrapper)
      {
         super();
         var_3908 = param1.readShort();
         var_4497 = param1.readString();
         var_808 = param1.readInteger();
         readAdditionalParams(param1);
         _petFigureString = param1.readString();
         var_3127 = new Vector.<int>();
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_3127.push(param1.readInteger());
            _loc2_++;
         }
         var_2711 = param1.readString();
         var_3946 = param1.readString();
      }
      
      public function readAdditionalParams(param1:IMessageDataWrapper) : void
      {
      }
      
      public function get productTypeId() : int
      {
         return var_3908;
      }
      
      public function get itemTypeId() : String
      {
         return var_4497;
      }
      
      public function get score() : int
      {
         return var_808;
      }
      
      public function get petFigureString() : String
      {
         return _petFigureString;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return var_3127;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get rarity() : String
      {
         return var_3946;
      }
   }
}

