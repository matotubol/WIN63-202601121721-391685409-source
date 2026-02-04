package com.sulake.habbo.freeflowchat.history
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.class_2434;
   import package_42.class_1945;
   
   public class ChatHistoryBuffer implements class_13
   {
      
      private const MAX_CHAT_ITEMS:int = 1000;
      
      private var var_59:HabboFreeFlowChat;
      
      private var var_80:Vector.<class_2434> = new Vector.<class_2434>(0);
      
      public function ChatHistoryBuffer(param1:HabboFreeFlowChat)
      {
         super();
         var_59 = param1;
      }
      
      public function dispose() : void
      {
         var_80 = null;
         var_59 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_59 == null;
      }
      
      public function insertChat(param1:ChatItem) : void
      {
         var _loc2_:class_2434 = null;
         try
         {
            _loc2_ = var_59.chatBubbleFactory.getHistoryLineEntry(param1);
         }
         catch(e:Error)
         {
            if(e.errorID == 2015)
            {
               return;
            }
            throw e;
         }
         var_80.push(_loc2_);
         checkBufferOverflowAndSpliceTop(_loc2_);
         if(var_59.chatHistoryScrollView.isActive)
         {
            var_59.chatHistoryScrollView.addHistoryEntry(var_80[var_80.length - 1]);
         }
      }
      
      public function insertRoomChange(param1:class_1945) : void
      {
         var _loc2_:class_2434 = var_59.chatBubbleFactory.getHistoryRoomChangeEntry(param1);
         var_80.push(_loc2_);
         checkBufferOverflowAndSpliceTop(_loc2_);
      }
      
      private function checkBufferOverflowAndSpliceTop(param1:class_2434) : void
      {
         if(var_80.length > 1000)
         {
            var_59.chatHistoryScrollView.scrollUpAndSpliceTopItem(param1.bitmap.height - param1.overlap.y - 8);
            var_80.splice(0,1);
         }
      }
      
      public function get entries() : Vector.<class_2434>
      {
         return var_80;
      }
      
      public function get totalHeight() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_ in var_80)
         {
            _loc2_ += _loc1_.bitmap.height - _loc1_.overlap.y - 8;
         }
         return _loc2_;
      }
   }
}

