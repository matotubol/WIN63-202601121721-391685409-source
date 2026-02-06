package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3590
   {
      
      private var _groupId:int;
      
      private var _name:String;
      
      private var var_735:String;
      
      private var _icon:String;
      
      private var var_1744:int;
      
      private var var_5264:int;
      
      private var var_1154:int;
      
      private var var_697:int;
      
      private var var_2033:int;
      
      private var var_1847:int;
      
      private var var_1936:String;
      
      private var var_2123:int;
      
      public function class_3590()
      {
         super();
      }
      
      public static function readFromMessage(param1:IMessageDataWrapper) : class_3590
      {
         return fillFromMessage(new class_3590(),param1);
      }
      
      internal static function fillFromMessage(param1:class_3590, param2:IMessageDataWrapper) : class_3590
      {
         param1._groupId = param2.readInteger();
         param1._name = param2.readString();
         param1.var_735 = param2.readString();
         param1._icon = param2.readString();
         param1.var_1744 = param2.readInteger();
         param1.var_5264 = param2.readInteger();
         param1.var_1154 = param2.readInteger();
         param1.var_697 = param2.readInteger();
         param1.var_2033 = param2.readInteger();
         param1.var_1847 = param2.readInteger();
         param1.var_1936 = param2.readString();
         param1.var_2123 = param2.readInteger();
         return param1;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function get icon() : String
      {
         return _icon;
      }
      
      public function get totalThreads() : int
      {
         return var_1744;
      }
      
      public function get leaderboardScore() : int
      {
         return var_5264;
      }
      
      public function get totalMessages() : int
      {
         return var_1154;
      }
      
      public function get unreadMessages() : int
      {
         return var_697;
      }
      
      public function get lastMessageId() : int
      {
         return var_2033;
      }
      
      public function get lastMessageAuthorId() : int
      {
         return var_1847;
      }
      
      public function get lastMessageAuthorName() : String
      {
         return var_1936;
      }
      
      public function get lastMessageTimeAsSecondsAgo() : int
      {
         return var_2123;
      }
      
      public function updateFrom(param1:class_3590) : void
      {
         var_1744 = param1.var_1744;
         var_1154 = param1.var_1154;
         var_697 = param1.var_697;
         var_1847 = param1.var_1847;
         var_1936 = param1.var_1936;
         var_2033 = param1.var_2033;
         var_2123 = param1.var_2123;
      }
      
      public function get lastReadMessageId() : int
      {
         return var_1154 - var_697;
      }
      
      public function set lastReadMessageId(param1:int) : void
      {
         var_697 = var_1154 - param1;
         if(var_697 < 0)
         {
            var_697 = 0;
         }
      }
      
      public function addNewThread(param1:class_3434) : void
      {
         var_1847 = param1.lastMessageAuthorId;
         var_1936 = param1.lastMessageAuthorName;
         var_2033 = param1.lastMessageId;
         var_2123 = param1.lastMessageTimeAsSecondsAgo;
         var_1744 = var_1744 + 1;
         var_1154 = var_1154 + 1;
         var_697 = 0;
      }
   }
}

