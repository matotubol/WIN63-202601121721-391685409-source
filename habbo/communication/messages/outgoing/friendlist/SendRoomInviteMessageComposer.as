package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class SendRoomInviteMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_1818:Array = [];
      
      private var _msg:String;
      
      public function SendRoomInviteMessageComposer(param1:String)
      {
         super();
         this._msg = param1;
      }
      
      public function getMessageArray() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc1_.push(this.var_1818.length);
         _loc2_ = 0;
         while(_loc2_ < this.var_1818.length)
         {
            _loc1_.push(this.var_1818[_loc2_]);
            _loc2_++;
         }
         _loc1_.push(this._msg);
         return _loc1_;
      }
      
      public function addInvitedFriend(param1:int) : void
      {
         this.var_1818.push(param1);
      }
      
      public function dispose() : void
      {
         this.var_1818 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

