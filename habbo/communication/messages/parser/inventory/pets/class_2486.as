package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2486
   {
      
      private var var_3814:int;
      
      private var var_3349:int;
      
      private var _color:String;
      
      private var var_3980:int;
      
      private var var_3681:int;
      
      private var var_2365:Array;
      
      public function class_2486(param1:IMessageDataWrapper)
      {
         super();
         var_3814 = param1.readInteger();
         var_3349 = param1.readInteger();
         _color = param1.readString();
         var_3980 = param1.readInteger();
         var_2365 = [];
         var_3681 = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < var_3681)
         {
            var_2365.push(param1.readInteger());
            var_2365.push(param1.readInteger());
            var_2365.push(param1.readInteger());
            _loc2_++;
         }
      }
      
      public function get typeId() : int
      {
         return var_3814;
      }
      
      public function get paletteId() : int
      {
         return var_3349;
      }
      
      public function get color() : String
      {
         return _color;
      }
      
      public function get breedId() : int
      {
         return var_3980;
      }
      
      public function get figureString() : String
      {
         var _loc2_:String = typeId + " " + paletteId + " " + color;
         _loc2_ += " " + customPartCount;
         for each(var _loc1_ in customParts)
         {
            _loc2_ += " " + _loc1_;
         }
         return _loc2_;
      }
      
      public function get customParts() : Array
      {
         return var_2365;
      }
      
      public function get customPartCount() : int
      {
         return var_3681;
      }
   }
}

