package com.sulake.habbo.communication.messages.parser.avatar
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FigureUpdateEventParser implements IMessageParser
   {
      
      private var var_975:String;
      
      private var var_111:String;
      
      public function FigureUpdateEventParser()
      {
         super();
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function flush() : Boolean
      {
         var_975 = "";
         var_111 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_975 = param1.readString();
         var_111 = param1.readString();
         if(var_111)
         {
            var_111 = var_111.toUpperCase();
         }
         return true;
      }
   }
}

