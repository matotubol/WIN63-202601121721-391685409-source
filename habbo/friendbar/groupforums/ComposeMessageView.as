package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.utils.FriendlyTime;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_2670;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_3434;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_3590;
   
   public class ComposeMessageView
   {
      
      public static const SUBJECT_MIN_LENGTH:int = 10;
      
      public static const SUBJECT_MAX_LENGTH:int = 120;
      
      public static const MESSAGE_MIN_LENGTH:int = 10;
      
      public static const MESSAGE_MAX_LENGTH:int = 4000;
      
      public static const const_817:int = 30000;
      
      private var var_55:GroupForumController;
      
      private var var_172:GroupForumView;
      
      private var var_323:Timer;
      
      private var _window:class_2250;
      
      private var var_894:ITextFieldWindow;
      
      private var var_940:ITextFieldWindow;
      
      private var var_800:class_1741;
      
      private var _status:class_1741;
      
      private var var_95:class_3590;
      
      private var var_1096:class_3434;
      
      private var _hasErrors:Boolean = false;
      
      private var var_2219:Boolean = false;
      
      public function ComposeMessageView(param1:GroupForumView, param2:int, param3:int, param4:class_3590, param5:class_3434, param6:class_2670)
      {
         super();
         var_172 = param1;
         var_55 = var_172.controller;
         var_95 = param4;
         var_1096 = param5;
         _window = class_2250(var_55.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_compose_message_xml())));
         _window.x = param2;
         var _loc7_:int = int(var_55.windowManager.getDesktop(1).width);
         if(_window.x + _window.width > _loc7_)
         {
            _window.x = _loc7_ - _window.width;
         }
         _window.y = param3;
         initControls(param6);
         if(_status.caption.length == 0)
         {
            _status.caption = var_55.localizationManager.getLocalization("groupforum.compose.reply_hint");
         }
         var_323 = new Timer(1000,0);
         var_323.addEventListener("timer",onTimerEvent);
         var_323.start();
      }
      
      public function focus(param1:class_3590, param2:class_3434, param3:class_2670) : void
      {
         if(!var_2219)
         {
            var_95 = param1;
            if(var_1096 != null && param2 == null)
            {
               var_894.text = "";
            }
            var_1096 = param2;
            initControls(param3);
         }
         _window.activate();
      }
      
      private function initControls(param1:class_2670) : void
      {
         var _loc3_:IRegionWindow = GroupForumView.initTopAreaForForum(_window,var_95);
         _loc3_.removeEventListener("WME_CLICK",onTopAreaClick);
         _loc3_.addEventListener("WME_CLICK",onTopAreaClick);
         var _loc5_:class_1741 = _window.findChildByName("thread_subject_header");
         var_894 = _window.findChildByName("thread_subject") as ITextFieldWindow;
         if(var_1096)
         {
            _loc5_.caption = var_55.localizationManager.getLocalization("groupforum.compose.subject_replying_to");
            var_894.text = var_1096.header;
            var_894.disable();
         }
         else
         {
            _loc5_.caption = var_55.localizationManager.getLocalization("groupforum.compose.subject");
            var_894.addEventListener("WKE_KEY_UP",onHeaderKeyUpEvent);
            var_894.maxChars = 120;
            var_894.enable();
         }
         var_940 = _window.findChildByName("message_text") as ITextFieldWindow;
         var_940.removeEventListener("WKE_KEY_UP",onMessageKeyUpEvent);
         var_940.addEventListener("WKE_KEY_UP",onMessageKeyUpEvent);
         var_940.maxChars = 4000;
         if(param1 != null)
         {
            addQuote(param1);
         }
         var _loc2_:class_1741 = _window.findChildByName("cancel_btn");
         _loc2_.removeEventListener("WME_CLICK",onCancelButtonClick);
         _loc2_.addEventListener("WME_CLICK",onCancelButtonClick);
         var _loc4_:class_1741 = _window.findChildByName("header_button_close");
         _loc4_.removeEventListener("WME_CLICK",onCancelButtonClick);
         _loc4_.addEventListener("WME_CLICK",onCancelButtonClick);
         var_800 = _window.findChildByName("post_btn");
         var_800.removeEventListener("WME_CLICK",onPostButtonClick);
         var_800.addEventListener("WME_CLICK",onPostButtonClick);
         _status = _window.findChildByName("status_text");
         validateInputs();
      }
      
      private function addQuote(param1:class_2670) : void
      {
         var _loc2_:* = undefined;
         var _loc4_:StringBuffer = new StringBuffer();
         _loc4_.add(var_940.text);
         if(_loc4_.length > 0)
         {
            _loc4_.add("\r\r");
         }
         _loc4_.add(var_55.localizationManager.getLocalizationWithParams("groupforum.compose.reply_template","","author_name",param1.authorName,"creation_time",var_172.getAsDaysHoursMinutes(param1.creationTimeAsSecondsAgo)));
         _loc4_.add("\r");
         var _loc5_:Array = param1.messageText.split("\r");
         var _loc6_:Boolean = false;
         for each(var _loc3_ in _loc5_)
         {
            _loc2_ = MessageListView.const_30.exec(_loc3_);
            if(_loc2_ != null)
            {
               if(!_loc6_)
               {
                  _loc6_ = true;
                  _loc4_.add("> ").add(var_55.localizationManager.getLocalization("groupforum.compose.skipped_quote")).add("\r");
               }
            }
            else
            {
               _loc4_.add("> ").add(_loc3_).add("\r");
               _loc6_ = false;
            }
         }
         _loc4_.add("\r");
         var_940.text = _loc4_.toString();
      }
      
      public function dispose() : void
      {
         var_323.stop();
         var_323.removeEventListener("timer",onTimerEvent);
         var_323 = null;
         var_55.composeMessageView = null;
         _window.dispose();
         _window = null;
      }
      
      private function onTimerEvent(param1:TimerEvent) : void
      {
         validateInputs();
      }
      
      private function onHeaderKeyUpEvent(param1:WindowKeyboardEvent) : void
      {
         validateInputs();
      }
      
      private function onMessageKeyUpEvent(param1:WindowKeyboardEvent) : void
      {
         validateInputs();
      }
      
      private function onTopAreaClick(param1:WindowMouseEvent) : void
      {
         var_55.context.createLinkEvent("group/" + var_95.groupId);
      }
      
      private function onPostButtonClick(param1:WindowMouseEvent) : void
      {
         if(var_2219)
         {
            return;
         }
         validateInputs();
         if(_hasErrors)
         {
            return;
         }
         var_2219 = true;
         var_894.disable();
         var_940.disable();
         var_800.disable();
         _status.caption = var_55.localizationManager.getLocalization("groupforum.compose.posting");
         if(var_1096)
         {
            var_55.postNewMessage(var_95.groupId,var_1096.threadId,var_940.text);
         }
         else
         {
            var_55.postNewThread(var_95.groupId,var_894.text,var_940.text);
         }
      }
      
      private function onCancelButtonClick(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function validateInputs() : void
      {
         _hasErrors = false;
         if(!var_1096)
         {
            if(var_894.text.length <= 10)
            {
               _hasErrors = true;
               _status.caption = var_55.localizationManager.getLocalization("groupforum.compose.subject_too_short");
            }
         }
         if(!_hasErrors && var_940.text.length <= 10)
         {
            _hasErrors = true;
            _status.caption = var_55.localizationManager.getLocalization("groupforum.compose.message_too_short");
         }
         if(!_hasErrors && !var_2219)
         {
            var _loc1_:int = getTimer() - var_55.lastPostTime;
            _hasErrors = true;
            _status.caption = var_55.localizationManager.getLocalizationWithParams("groupforum.compose.post_cooldown","","time_remaining",FriendlyTime.getFriendlyTime(var_55.localizationManager,(30000 - 0) / 1000 + 1,"",1));
         }
         if(!var_2219 && !_hasErrors)
         {
            var_800.enable();
            _status.caption = "";
         }
         else
         {
            var_800.disable();
         }
      }
   }
}

