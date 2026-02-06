package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3362 implements class_2565
   {
      
      private var var_1270:int;
      
      private var _userName:String;
      
      private var _selected:Boolean;
      
      public function class_3362(param1:IMessageDataWrapper)
      {
         super();
         this.var_1270 = param1.readInteger();
         this._userName = param1.readString();
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
      }
   }
}

