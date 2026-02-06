package com.sulake.habbo.communication.messages.outgoing.register
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class UpdateFigureDataMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function UpdateFigureDataMessageComposer(param1:String, param2:String)
      {
         super();
         var_24.push(param2);
         var_24.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
         var_24 = null;
      }
   }
}

