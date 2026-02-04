package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_4114 extends class_2870
   {
      
      private var var_3841:String;
      
      private var var_5044:String;
      
      public function class_4114(param1:IMessageDataWrapper)
      {
         super(param1);
         var_3841 = param1.readString();
         var_5044 = param1.readString();
      }
      
      public function get setId() : String
      {
         return var_3841;
      }
      
      public function get defaultCollectionName() : String
      {
         return var_5044;
      }
   }
}

