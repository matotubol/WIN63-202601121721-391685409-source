package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.outgoing.quest.ActivateQuestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.CancelQuestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetDailyQuestMessageComposer;
   import com.sulake.habbo.communication.messages.parser.quest.QuestDailyMessageEventParser;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISlotAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.class_4080;
   import com.sulake.habbo.communication.messages.incoming.quest.class_2098;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestDailyMessageEvent;
   
   public class DailyQuestWidget implements class_13, ILandingViewWidget, ISlotAwareWidget, class_4080
   {
      
      private var _landingView:HabboLandingView;
      
      private var _container:class_1812;
      
      private var var_24:class_2098;
      
      private var var_3670:int;
      
      private var var_3475:int;
      
      private var _index:int;
      
      private var var_4878:int;
      
      private var var_2508:int;
      
      private var var_3163:String;
      
      public function DailyQuestWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public static function moveChildrenToRow(param1:class_1812, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc5_:class_1741 = null;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc5_ = param1.getChildAt(_loc3_);
            _loc5_.x = _loc4_;
            _loc4_ += _loc5_.width + param2;
            _loc3_++;
         }
      }
      
      public function set configurationCode(param1:String) : void
      {
         var_3163 = param1;
      }
      
      public function set slot(param1:int) : void
      {
         var_2508 = param1;
      }
      
      public function get container() : class_1741
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
         var_24 = null;
      }
      
      public function initialize() : void
      {
         _container = class_1812(_landingView.getXmlWindow("daily_quest"));
         _landingView.communicationManager.addHabboConnectionMessageEvent(new QuestDailyMessageEvent(onDailyQuest));
         _container.findChildByName("accept_button").procedure = onAcceptButton;
         _container.findChildByName("go_button").procedure = onGoButton;
         _container.findChildByName("next_quest_region").procedure = onNextQuest;
         _container.findChildByName("cancel_quest_region").procedure = onCancelQuest;
         _container.findChildByName("easy_region").procedure = onEasyRegion;
         _container.findChildByName("hard_region").procedure = onHardRegion;
         var _loc1_:class_1741 = _container.findChildByName("hdr_line");
         var_4878 = _loc1_.x + _loc1_.width;
         GenericWidget.configureLayout(_landingView,var_2508,var_3163,_container);
      }
      
      public function refresh() : void
      {
         _index = 0;
         _landingView.send(new GetDailyQuestMessageComposer(true,0));
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function onDailyQuest(param1:IMessageEvent) : void
      {
         var _loc2_:QuestDailyMessageEventParser = QuestDailyMessageEventParser(param1.parser);
         var_24 = _loc2_.quest;
         var_3670 = _loc2_.easyQuestCount;
         var_3475 = _loc2_.hardQuestCount;
         refreshContent();
      }
      
      private function refreshContent() : void
      {
         _container.findChildByName("caption_txt").caption = var_24 ? getChainSpecificText("chaincaption") : getText("landing.view.quest.currenttask.alldone.caption");
         _container.findChildByName("info_txt").caption = var_24 ? getChainSpecificText("chaininfo") : getText("landing.view.quest.currenttask.alldone.info");
         _container.findChildByName("accept_button").visible = var_24 && !var_24.accepted;
         _container.findChildByName("next_quest_region").visible = var_24 && !var_24.accepted && (var_24.easy ? var_3670 : var_3475) > 1;
         _container.findChildByName("next_quest_txt").caption = getText("landing.view.quest.nextquest." + (var_24 && var_24.easy ? "easy" : "hard"));
         _container.findChildByName("title_txt").caption = getText("landing.view.quest.title." + (var_24 && var_24.accepted ? "accepted" : "notaccepted"));
         HabboLandingView.positionAfterAndStretch(_container,"title_txt","hdr_line");
         _container.findChildByName("cancel_quest_region").visible = var_24 && var_24.accepted;
         _container.findChildByName("current_quest_border").visible = var_24 && var_24.accepted;
         if(var_24)
         {
            _landingView.localizationManager.registerParameter("landing.view.quest.currenttask","task",getQuestName());
         }
         var _loc1_:class_1812 = class_1812(_container.findChildByName("difficulty_container"));
         var _loc2_:int = _loc1_.x + _loc1_.width;
         _loc1_.visible = var_24 && !var_24.accepted && var_3670 > 0 && var_3475 > 0;
         setupDifficultyText("easy_region",var_24 && !var_24.easy);
         setupDifficultyText("hard_region",var_24 && var_24.easy);
         moveChildrenToRow(_loc1_,5);
         _loc1_.width = _loc1_.findChildByName("hard_region").x + _loc1_.findChildByName("hard_region").width;
         _loc1_.x = _loc2_ - _loc1_.width;
         var _loc4_:class_1741 = _container.findChildByName("hdr_line");
         var _loc3_:int = int(_loc1_.visible ? _loc1_.x - 5 : var_4878);
         _loc4_.width = _loc3_ - _loc4_.x;
      }
      
      private function setupDifficultyText(param1:String, param2:Boolean) : void
      {
         var _loc4_:class_1812 = class_1812(_container.findChildByName(param1));
         var _loc3_:ITextWindow = ITextWindow(_loc4_.findChildByName("label_txt"));
         _loc3_.width = _loc3_.textWidth;
         _loc3_.underline = param2;
         _loc4_.width = _loc3_.width;
      }
      
      private function getChainSpecificKey(param1:String) : String
      {
         return "quests." + var_24.campaignCode + "." + var_24.chainCode + "." + param1;
      }
      
      private function getChainSpecificText(param1:String) : String
      {
         var _loc2_:String = getChainSpecificKey(param1);
         return "${" + _loc2_ + "}";
      }
      
      private function getText(param1:String) : String
      {
         return "${" + param1 + "}";
      }
      
      private function onGoButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.goToRoom();
         }
      }
      
      private function onEasyRegion(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            sendGetDailyQuest(true);
         }
      }
      
      private function onHardRegion(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            sendGetDailyQuest(false);
         }
      }
      
      public function getQuestName() : String
      {
         var _loc1_:String = var_24.getQuestLocalizationKey() + ".name";
         return "${" + _loc1_ + "}";
      }
      
      private function onAcceptButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.send(new ActivateQuestMessageComposer(var_24.id));
         }
      }
      
      private function onNextQuest(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _index = _index + 1;
            sendGetDailyQuest(var_24.easy);
         }
      }
      
      private function onCancelQuest(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.send(new CancelQuestMessageComposer());
         }
      }
      
      private function sendGetDailyQuest(param1:Boolean) : void
      {
         _landingView.send(new GetDailyQuestMessageComposer(param1,_index));
      }
   }
}

