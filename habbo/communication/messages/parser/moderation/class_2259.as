package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_2259 implements class_13
   {
      
      private var var_2358:Array;
      
      private var var_2605:Array;
      
      private var var_463:Array;
      
      private var var_4144:Boolean;
      
      private var var_5115:Boolean;
      
      private var var_4760:Boolean;
      
      private var var_4417:Boolean;
      
      private var var_4568:Boolean;
      
      private var var_4596:Boolean;
      
      private var var_3998:Boolean;
      
      private var _disposed:Boolean;
      
      public function class_2259(param1:IMessageDataWrapper)
      {
         super();
         var _loc2_:IssueInfoMessageEventParser = new IssueInfoMessageEventParser();
         var_463 = [];
         var_2358 = [];
         var_2605 = [];
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc3_)
         {
            if(_loc2_.parse(param1))
            {
               var_463.push(_loc2_.issueData);
            }
            _loc4_++;
         }
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         while(0 < _loc3_)
         {
            var_2358.push(param1.readString());
            _loc4_++;
         }
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         while(0 < _loc3_)
         {
            param1.readString();
            _loc4_++;
         }
         var_4144 = param1.readBoolean();
         var_5115 = param1.readBoolean();
         var_4760 = param1.readBoolean();
         var_4417 = param1.readBoolean();
         var_4568 = param1.readBoolean();
         var_4596 = param1.readBoolean();
         var_3998 = param1.readBoolean();
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         while(0 < _loc3_)
         {
            var_2605.push(param1.readString());
            _loc4_++;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         var_2358 = null;
         var_2605 = null;
         var_463 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get messageTemplates() : Array
      {
         return var_2358;
      }
      
      public function get roomMessageTemplates() : Array
      {
         return var_2605;
      }
      
      public function get issues() : Array
      {
         return var_463;
      }
      
      public function get cfhPermission() : Boolean
      {
         return var_4144;
      }
      
      public function get chatlogsPermission() : Boolean
      {
         return var_5115;
      }
      
      public function get alertPermission() : Boolean
      {
         return var_4760;
      }
      
      public function get kickPermission() : Boolean
      {
         return var_4417;
      }
      
      public function get banPermission() : Boolean
      {
         return var_4568;
      }
      
      public function get roomAlertPermission() : Boolean
      {
         return var_4596;
      }
      
      public function get roomKickPermission() : Boolean
      {
         return var_3998;
      }
   }
}

