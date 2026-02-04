package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3631
   {
      
      private var var_2711:String;
      
      private var var_4812:int;
      
      private var var_4827:Boolean;
      
      private var var_4737:Boolean;
      
      private var var_4789:int;
      
      private var var_4251:int;
      
      private var var_4449:class_2870;
      
      public function class_3631(param1:IMessageDataWrapper)
      {
         super();
         var_2711 = param1.readString();
         var_4812 = param1.readInteger();
         var_4827 = param1.readBoolean();
         var_4737 = param1.readBoolean();
         var_4789 = param1.readInteger();
         var_4251 = param1.readInteger();
         var_4449 = new class_2870(param1);
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get emeraldPrice() : int
      {
         return var_4812;
      }
      
      public function get isFeatured() : Boolean
      {
         return var_4827;
      }
      
      public function get isLimited() : Boolean
      {
         return var_4737;
      }
      
      public function get mintLimit() : int
      {
         return var_4789;
      }
      
      public function get mintedCount() : int
      {
         return var_4251;
      }
      
      public function get productInfo() : class_2870
      {
         return var_4449;
      }
   }
}

