package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3364
   {
      
      private var var_4755:int;
      
      private var var_3523:String;
      
      private var var_588:Boolean;
      
      private var var_4705:Boolean;
      
      private var var_5120:String;
      
      private var var_2826:String;
      
      private var var_5110:Boolean;
      
      public function class_3364(param1:IMessageDataWrapper)
      {
         super();
         var_4755 = param1.readInteger();
         var_3523 = param1.readString();
         var_588 = param1.readBoolean();
         var_4705 = param1.readBoolean();
         var_5120 = param1.readString();
         var_2826 = param1.readString();
         var_5110 = param1.readBoolean();
      }
      
      public function get nodeId() : int
      {
         return var_4755;
      }
      
      public function get nodeName() : String
      {
         return var_3523;
      }
      
      public function get visible() : Boolean
      {
         return var_588;
      }
      
      public function get automatic() : Boolean
      {
         return var_4705;
      }
      
      public function get staffOnly() : Boolean
      {
         return var_5110;
      }
      
      public function get automaticCategoryKey() : String
      {
         return var_5120;
      }
      
      public function get globalCategoryKey() : String
      {
         return var_2826;
      }
      
      public function get visibleName() : String
      {
         return var_2826 == "" ? var_3523 : "${navigator.flatcategory.global." + var_2826 + "}";
      }
   }
}

