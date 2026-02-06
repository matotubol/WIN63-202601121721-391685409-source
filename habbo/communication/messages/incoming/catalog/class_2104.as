package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2104
   {
      
      public static const PRODUCT_TYPE_ITEM:String = "i";
      
      public static const PRODUCT_TYPE_STUFF:String = "s";
      
      public static const PRODUCT_TYPE_EFFECT:String = "e";
      
      public static const PRODUCT_TYPE_BADGE:String = "b";
      
      public static const const_1075:String = "cl";
      
      private var var_576:String;
      
      private var var_4159:int;
      
      private var var_744:String;
      
      private var var_2475:int;
      
      private var var_3668:Boolean;
      
      private var var_4579:int;
      
      private var var_3181:int;
      
      public function class_2104(param1:IMessageDataWrapper)
      {
         super();
         var_576 = param1.readString();
         var _loc2_:String = var_576;
         if("b" !== _loc2_)
         {
            var_4159 = param1.readInteger();
            var_744 = param1.readString();
            var_2475 = param1.readInteger();
            var_3668 = param1.readBoolean();
            if(var_3668)
            {
               var_4579 = param1.readInteger();
               var_3181 = param1.readInteger();
            }
         }
         else
         {
            var_744 = param1.readString();
            var_2475 = 1;
         }
      }
      
      public function get productType() : String
      {
         return var_576;
      }
      
      public function get furniClassId() : int
      {
         return var_4159;
      }
      
      public function get extraParam() : String
      {
         return var_744;
      }
      
      public function get productCount() : int
      {
         return var_2475;
      }
      
      public function get uniqueLimitedItem() : Boolean
      {
         return var_3668;
      }
      
      public function get uniqueLimitedItemSeriesSize() : int
      {
         return var_4579;
      }
      
      public function get uniqueLimitedItemsLeft() : int
      {
         return var_3181;
      }
   }
}

