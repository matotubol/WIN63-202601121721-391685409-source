package com.sulake.habbo.friendbar.groupforums
{
   import flash.utils.Dictionary;
   import package_155.class_2670;
   
   public class MessagesListData
   {
      
      private var var_2326:int;
      
      private var var_369:int;
      
      private var var_1154:int;
      
      private var var_2613:Array;
      
      private var var_3599:Dictionary;
      
      public function MessagesListData(param1:int, param2:int, param3:int, param4:Array)
      {
         super();
         var_2326 = param1;
         var_369 = param3;
         var_1154 = param2;
         var_2613 = param4;
         var_3599 = new Dictionary();
         var _loc5_:int = 0;
         while(0 < param4.length)
         {
            var _loc6_:class_2670 = param4[0];
            var_3599[null.messageId] = null;
            _loc5_++;
         }
      }
      
      public function get threadId() : int
      {
         return var_2326;
      }
      
      public function get startIndex() : int
      {
         return var_369;
      }
      
      public function get totalMessages() : int
      {
         return var_1154;
      }
      
      public function get messages() : Array
      {
         return var_2613;
      }
      
      public function get messagesById() : Dictionary
      {
         return var_3599;
      }
      
      public function get size() : int
      {
         return var_2613.length;
      }
   }
}

