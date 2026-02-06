package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_3362;
   
   [SecureSWF(rename="true")]
   public class FlatControllerAddedEventParser implements IMessageParser
   {
      
      private var _flatId:int;
      
      private var var_24:class_3362;
      
      public function FlatControllerAddedEventParser()
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
         this.var_24 = new class_3362(param1);
         return true;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get data() : class_3362
      {
         return var_24;
      }
   }
}

