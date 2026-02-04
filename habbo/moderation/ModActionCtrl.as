package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.utils.StringUtil;
   import package_122.class_2446;
   import package_122.class_2484;
   import package_122.class_2535;
   import package_122.class_2645;
   import package_122.class_2678;
   import package_122.class_3402;
   import package_122.class_3616;
   import package_18.class_2218;
   import package_18.class_3499;
   import package_79.class_3291;
   
   public class ModActionCtrl implements class_13, ITrackedWindow
   {
      
      private static var var_294:Array;
      
      private static var var_2248:class_55;
      
      private var _main:ModerationManager;
      
      private var var_696:int;
      
      private var _targetUserName:String;
      
      private var var_2726:class_3291;
      
      private var _frame:class_2250;
      
      private var _topicDropdown:class_2261;
      
      private var var_2668:Array;
      
      private var _actionTypeDropdown:class_2261;
      
      private var var_878:ITextFieldWindow;
      
      private var _disposed:Boolean;
      
      private var var_1905:UserInfoCtrl;
      
      public function ModActionCtrl(param1:ModerationManager, param2:int, param3:String, param4:class_3291, param5:UserInfoCtrl)
      {
         super();
         _main = param1;
         var_696 = param2;
         _targetUserName = param3;
         var_2726 = param4;
         var_1905 = param5;
         if(var_294 == null)
         {
            var_294 = [];
            var_294.push(new ModActionDefinition(1,"Alert",1,1,0));
            var_294.push(new ModActionDefinition(2,"Mute 1h",2,2,0));
            var_294.push(new ModActionDefinition(3,"Ban 18h",3,3,0));
            var_294.push(new ModActionDefinition(4,"Ban 7 days",3,4,0));
            var_294.push(new ModActionDefinition(5,"Ban 30 days (step 1)",3,5,0));
            var_294.push(new ModActionDefinition(7,"Ban 30 days (step 2)",3,7,0));
            var_294.push(new ModActionDefinition(6,"Ban 100 years",3,6,0));
            var_294.push(new ModActionDefinition(106,"Ban avatar-only 100 years",3,6,0));
            var_294.push(new ModActionDefinition(101,"Kick",4,0,0));
            var_294.push(new ModActionDefinition(102,"Lock trade 1 week",5,0,168));
            var_294.push(new ModActionDefinition(104,"Lock trade permanent",5,0,876000));
            var_294.push(new ModActionDefinition(105,"Message",6,0,0));
         }
         _main.issueManager.addModActionView(var_696,this);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         _frame = class_2250(_main.getXmlWindow("modact_summary"));
         _frame.caption = "Mod action on: " + _targetUserName;
         _frame.findChildByName("custom_sanction_button").procedure = onCustomSanctionButton;
         var_878 = ITextFieldWindow(_frame.findChildByName("message_input"));
         _frame.findChildByName("default_sanction_button").procedure = onDefaultSanctionButton;
         _frame.findChildByName("default_sanction_button").disable();
         initializeTopicToSanctionTypeMapping();
         initializeTopicDropdown();
         initializeActionTypeDropdown();
         var _loc1_:class_1741 = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
         _frame.visible = true;
      }
      
      public function getType() : int
      {
         return 7;
      }
      
      public function getId() : String
      {
         return _targetUserName;
      }
      
      public function getFrame() : class_2250
      {
         return _frame;
      }
      
      private function logEvent(param1:String, param2:String = "") : void
      {
         if(var_1905 != null)
         {
            var_1905.logEvent(param1,param2);
         }
      }
      
      private function trackAction(param1:String) : void
      {
         if(var_1905 != null && !var_1905.disposed)
         {
            var_1905.trackAction("modAction_" + param1);
         }
      }
      
      private function initializeTopicToSanctionTypeMapping() : void
      {
         if(var_2248 == null)
         {
            var_2248 = new class_55();
            var _loc2_:String = _main.getProperty("cfh.topic_id.to.sanction_type_id");
         }
      }
      
      private function initializeTopicDropdown() : void
      {
         _topicDropdown = class_2261(_frame.findChildByName("cfh_topics"));
         _topicDropdown.addEventListener("WE_SELECTED",refreshSanctionDataForSelectedTopic);
         var_2668 = [];
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         for each(var _loc4_ in _main.issueManager.getCfhTopics())
         {
            for each(var _loc3_ in _loc4_.topics)
            {
               _loc1_[_loc2_] = "${help.cfh.topic." + _loc3_.id + "}";
               var_2668[_loc2_] = _loc3_.id;
               _loc2_++;
            }
         }
         _topicDropdown.populate(_loc1_);
      }
      
      private function refreshSanctionDataForSelectedTopic(param1:class_1758) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = _topicDropdown.selection;
         var _loc2_:int = int(var_2668[_loc5_]);
         var _loc3_:int = var_2248.getValue(_loc2_);
         if(!_loc3_)
         {
            _loc3_ = var_2248.getValue(0);
         }
         if(_loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ < var_294.length)
            {
               if(var_294[_loc4_].actionId == _loc3_)
               {
                  _actionTypeDropdown.selection = _loc4_;
                  break;
               }
               _loc4_++;
            }
         }
         else
         {
            _actionTypeDropdown.selection = -1;
         }
         _main.issueManager.requestSanctionDataForAccount(var_696,_loc2_);
      }
      
      public function showDefaultSanction(param1:int, param2:String) : void
      {
         if(_frame == null || param1 != var_696)
         {
            return;
         }
         var _loc3_:ITextWindow = _frame.findChildByName("default_sanction_label") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.caption = param2;
         }
         _frame.findChildByName("default_sanction_button").enable();
      }
      
      private function initializeActionTypeDropdown() : void
      {
         _actionTypeDropdown = class_2261(_frame.findChildByName("sanction_type"));
         var _loc1_:Array = [];
         for each(var _loc2_ in var_294)
         {
            _loc1_.push(_loc2_.name);
         }
         _actionTypeDropdown.populate(_loc1_);
      }
      
      private function onDefaultSanctionButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_topicDropdown.selection < 0)
         {
            _main.windowManager.alert("Alert","Please select a topic.",0,onAlertClose);
            return;
         }
         class_21.log("Giving default sanction...");
         trackAction("defaultAction");
         logEvent("action.default");
         var _loc3_:int = int(var_2668[_topicDropdown.selection]);
         _main.connection.send(new class_2645(var_696,_loc3_,var_878.text,getIssueId()));
         dispose();
      }
      
      private function onCustomSanctionButton(param1:class_1758, param2:class_1741) : void
      {
         var _loc6_:* = false;
         var _loc3_:int = 0;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_topicDropdown.selection < 0)
         {
            _main.windowManager.alert("Alert","Please select a topic.",0,onAlertClose);
            return;
         }
         if(_actionTypeDropdown.selection < 0)
         {
            _main.windowManager.alert("Alert","Please select a sanction.",0,onAlertClose);
            return;
         }
         var _loc4_:int = int(var_2668[_topicDropdown.selection]);
         var _loc5_:ModActionDefinition;
         switch((_loc5_ = var_294[_actionTypeDropdown.selection]).actionType - 1)
         {
            case 0:
               if(!_main.initMsg.alertPermission)
               {
                  _main.windowManager.alert("Alert","You have insufficient permissions.",0,onAlertClose);
                  return;
               }
               trackAction("sendCaution");
               _main.connection.send(new class_3402(var_696,var_878.text,_loc4_,getIssueId()));
               break;
            case 1:
               trackAction("mute");
               _main.connection.send(new class_2535(var_696,var_878.text,_loc4_,getIssueId()));
               break;
            case 2:
               if(!_main.initMsg.banPermission)
               {
                  _main.windowManager.alert("Alert","You have insufficient permissions.",0,onAlertClose);
                  return;
               }
               trackAction("ban");
               _loc6_ = _loc5_.actionId == 106;
               _main.connection.send(new class_2484(var_696,var_878.text,_loc4_,_loc5_.sanctionTypeId,_loc6_,getIssueId()));
               break;
            case 3:
               if(!_main.initMsg.kickPermission)
               {
                  _main.windowManager.alert("Alert","You have insufficient permissions.",0,onAlertClose);
                  return;
               }
               trackAction("kick");
               _main.connection.send(new class_3616(var_696,var_878.text,_loc4_,getIssueId()));
               break;
            case 4:
               trackAction("trading_lock");
               _loc3_ = _loc5_.actionLengthHours * 60;
               _main.connection.send(new class_2678(var_696,var_878.text,_loc3_,_loc4_,getIssueId()));
               break;
            case 5:
               if(StringUtil.isEmpty(var_878.text))
               {
                  _main.windowManager.alert("Alert","Please write a message to user.",0,onAlertClose);
                  return;
               }
               trackAction("sendCaution");
               _main.connection.send(new class_2446(var_696,var_878.text,_loc4_,getIssueId()));
         }
         logEvent("action.custom","unknown");
         dispose();
      }
      
      private function onClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("close");
         dispose();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         _topicDropdown = null;
         var_878 = null;
         _main.issueManager.removeModActionView(var_696);
         _main = null;
      }
      
      private function onAlertClose(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
      }
      
      private function getIssueId() : int
      {
         return var_2726 != null ? var_2726.issueId : -1;
      }
   }
}

