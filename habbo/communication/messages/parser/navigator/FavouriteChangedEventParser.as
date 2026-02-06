package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FavouriteChangedEventParser implements IMessageParser
   {
      
      private var _flatId:int;
      
      private var var_3226:Boolean;
      
      public function FavouriteChangedEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._flatId = param1.readInteger();
         this.var_3226 = param1.readBoolean();
         return true;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get added() : Boolean
      {
         return var_3226;
      }
   }
}

