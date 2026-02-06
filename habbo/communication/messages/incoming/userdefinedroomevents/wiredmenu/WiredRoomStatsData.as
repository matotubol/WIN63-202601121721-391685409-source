package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class WiredRoomStatsData
   {
      
      private var var_3971:Number;
      
      private var var_4833:Number;
      
      private var var_4532:Boolean;
      
      private var var_4659:int;
      
      private var var_4747:int;
      
      private var var_4200:int;
      
      private var var_4885:int;
      
      private var var_4007:int;
      
      private var var_4306:int;
      
      private var var_4154:int;
      
      private var var_5121:int;
      
      private var var_4983:int;
      
      private var var_4385:int;
      
      public function WiredRoomStatsData(param1:IMessageDataWrapper)
      {
         super();
         var_3971 = param1.readDouble();
         var_4833 = param1.readDouble();
         var_4532 = param1.readBoolean();
         var_4659 = param1.readInteger();
         var_4747 = param1.readInteger();
         var_4200 = param1.readInteger();
         var_4885 = param1.readInteger();
         var_4007 = param1.readInteger();
         var_4306 = param1.readInteger();
         var_4154 = param1.readInteger();
         var_5121 = param1.readInteger();
         var_4983 = param1.readInteger();
         var_4385 = param1.readInteger();
      }
      
      public function get executionCost() : Number
      {
         return var_3971;
      }
      
      public function get executionCostCap() : Number
      {
         return var_4833;
      }
      
      public function get isHeavy() : Boolean
      {
         return var_4532;
      }
      
      public function get floorItemCount() : int
      {
         return var_4659;
      }
      
      public function get floorItemCap() : int
      {
         return var_4747;
      }
      
      public function get wallItemCount() : int
      {
         return var_4200;
      }
      
      public function get wallItemCap() : int
      {
         return var_4885;
      }
      
      public function get permanentFurniVariables() : int
      {
         return var_4007;
      }
      
      public function get maxPermanentFurniVariables() : int
      {
         return var_4306;
      }
      
      public function get permanentUserVariables() : int
      {
         return var_4154;
      }
      
      public function get maxPermanentUserVariables() : int
      {
         return var_5121;
      }
      
      public function get permanentGlobalVariables() : int
      {
         return var_4983;
      }
      
      public function get maxPermanentGlobalVariables() : int
      {
         return var_4385;
      }
   }
}

