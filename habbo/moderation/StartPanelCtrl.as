package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import package_122.class_3143;
   import package_50.class_1996;
   
   public class StartPanelCtrl implements class_13
   {
      
      private var _main:ModerationManager;
      
      private var _frame:class_2250;
      
      private var var_1270:int;
      
      private var _isGuestRoom:Boolean;
      
      private var var_1951:int;
      
      private var _disposed:Boolean = false;
      
      public function StartPanelCtrl(param1:ModerationManager)
      {
         super();
         _main = param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _main = null;
            if(_frame)
            {
               _frame.dispose();
               _frame = null;
            }
         }
      }
      
      public function userSelected(param1:int, param2:String) : void
      {
         if(_frame == null)
         {
            return;
         }
         var_1270 = param1;
         _frame.findChildByName("userinfo_but").enable();
         (class_1812(_frame.findChildByName("userinfo_but")).findChildByName("offence_name") as ILabelWindow).textColor = 0;
         class_1812(_frame.findChildByName("userinfo_but")).findChildByName("offence_name").caption = "User info: " + param2;
      }
      
      public function guestRoomEntered(param1:class_1996) : void
      {
         if(_frame == null || param1 == null)
         {
            return;
         }
         _frame.findChildByName("room_tool_but").enable();
         (class_1812(_frame.findChildByName("room_tool_but")).findChildByName("offence_name") as ILabelWindow).textColor = 0;
         enableChatlogButton();
         _isGuestRoom = true;
         var_1951 = param1.guestRoomId;
      }
      
      public function roomExited() : void
      {
         if(_frame == null)
         {
            return;
         }
         _frame.findChildByName("room_tool_but").disable();
         _frame.findChildByName("chatlog_but").disable();
      }
      
      public function show() : void
      {
         if(_frame == null)
         {
            _frame = class_2250(_main.getXmlWindow("start_panel"));
            _frame.findChildByName("room_tool_but").addEventListener("WME_CLICK",onRoomToolButton);
            _frame.findChildByName("chatlog_but").addEventListener("WME_CLICK",onChatlogButton);
            _frame.findChildByName("ticket_queue_but").addEventListener("WME_CLICK",onTicketQueueButton);
            _frame.findChildByName("userinfo_but").addEventListener("WME_CLICK",onUserinfoButton);
            _frame.findChildByName("room_tool_but").addEventListener("WME_OVER",onMouseOver);
            _frame.findChildByName("chatlog_but").addEventListener("WME_OVER",onMouseOver);
            _frame.findChildByName("ticket_queue_but").addEventListener("WME_OVER",onMouseOver);
            _frame.findChildByName("userinfo_but").addEventListener("WME_OVER",onMouseOver);
            _frame.findChildByName("room_tool_but").addEventListener("WME_OUT",onMouseOut);
            _frame.findChildByName("chatlog_but").addEventListener("WME_OUT",onMouseOut);
            _frame.findChildByName("ticket_queue_but").addEventListener("WME_OUT",onMouseOut);
            _frame.findChildByName("userinfo_but").addEventListener("WME_OUT",onMouseOut);
            _frame.findChildByName("userinfo_but").disable();
            _frame.findChildByName("room_tool_but").disable();
            _frame.findChildByName("chatlog_but").disable();
            (class_1812(_frame.findChildByName("userinfo_but")).findChildByName("offence_name") as ILabelWindow).textColor = 6710886;
            (class_1812(_frame.findChildByName("room_tool_but")).findChildByName("offence_name") as ILabelWindow).textColor = 6710886;
            (class_1812(_frame.findChildByName("chatlog_but")).findChildByName("offence_name") as ILabelWindow).textColor = 6710886;
         }
         _frame.visible = true;
      }
      
      private function enableChatlogButton() : void
      {
         if(_main.initMsg.chatlogsPermission)
         {
            _frame.findChildByName("chatlog_but").enable();
            (class_1812(_frame.findChildByName("chatlog_but")).findChildByName("offence_name") as ILabelWindow).textColor = 0;
         }
      }
      
      private function onMouseOver(param1:class_1758) : void
      {
         if(!param1.window.isEnabled())
         {
            return;
         }
         (param1.window as class_1812).findChildByName("mouseover").visible = true;
      }
      
      private function onMouseOut(param1:class_1758) : void
      {
         (param1.window as class_1812).findChildByName("mouseover").visible = false;
      }
      
      private function onRoomToolButton(param1:class_1758) : void
      {
         _main.windowTracker.show(new RoomToolCtrl(_main,var_1951),_frame,false,false,true);
      }
      
      private function onChatlogButton(param1:class_1758) : void
      {
         _main.windowTracker.show(new ChatlogCtrl(new class_3143(_isGuestRoom ? 0 : 1,var_1951),_main,4,var_1951),_frame,false,false,true);
      }
      
      private function onUserinfoButton(param1:class_1758) : void
      {
         _main.windowTracker.show(new UserInfoFrameCtrl(_main,var_1270),_frame,false,false,true);
      }
      
      private function onTicketQueueButton(param1:class_1758) : void
      {
         _main.issueManager.init();
      }
   }
}

