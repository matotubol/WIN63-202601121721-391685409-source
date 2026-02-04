package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import package_3.class_2022;
   import package_3.class_3489;
   import package_9.class_3210;
   
   public class class_3887 extends DefaultConditionType
   {
      
      private static var REQUEST_TIMEOUT:int = 5;
      
      private var _cont:class_1812;
      
      private var var_59:HabboUserDefinedRoomEvents;
      
      private var var_2078:Array;
      
      private var var_372:int = -1;
      
      private var var_4172:Number = 0;
      
      public function class_3887()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.ACTOR_IS_GROUP_MEMBER;
      }
      
      override public function get negativeCode() : int
      {
         return class_4100.NOT_ACTOR_IS_GROUP_MEMBER;
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc1_:int = 0;
         var _loc2_:class_3489 = null;
         if(getGroupTypeRadio(1).isSelected)
         {
            _loc1_ = getGroupMenu().selection;
            if(_loc1_ == -1)
            {
               return "";
            }
            _loc2_ = var_2078[getGroupMenu().selection];
            return _loc2_.groupId.toString();
         }
         return "";
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         var_59 = param3;
         _cont = param1;
         getGroupTypeRadio(1).addEventListener("WE_SELECT",onSpecifyGroupSelect);
         getGroupTypeRadio(1).addEventListener("WE_UNSELECT",onSpecifyGroupUnselect);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var_372 = param1.stringParam == "" ? -1 : int(param1.stringParam);
         initGuilds(var_2078 == null ? [] : var_2078);
         maybeGetGuildMemberships();
         if(param1.stringParam != "")
         {
            getGroupTypeSelector().setSelected(getGroupTypeRadio(1));
            getGroupMenu().visible = true;
         }
         else
         {
            getGroupTypeSelector().setSelected(getGroupTypeRadio(0));
            getGroupMenu().visible = false;
         }
      }
      
      private function maybeGetGuildMemberships() : void
      {
         var _loc1_:Number = new Date().time;
         if(_loc1_ > var_4172 + 1000 * REQUEST_TIMEOUT)
         {
            var_4172 = _loc1_;
            var_59.send(new class_3210());
         }
      }
      
      private function initGuilds(param1:Array) : void
      {
         var_2078 = param1;
         var _loc4_:Vector.<String> = new Vector.<String>();
         var _loc5_:int = 0;
         while(0 < var_2078.length)
         {
            var _loc2_:class_3489 = var_2078[0];
            _loc4_.push(null.groupName);
            if(null.groupId == var_372)
            {
               var _loc3_:int = 0;
            }
            _loc5_++;
         }
         getGroupMenu().populateWithVector(_loc4_);
      }
      
      override public function onGuildMemberships(param1:class_2022) : void
      {
         initGuilds(param1.guilds);
      }
      
      private function onSpecifyGroupSelect(param1:class_1758) : void
      {
         getGroupMenu().visible = true;
      }
      
      private function onSpecifyGroupUnselect(param1:class_1758) : void
      {
         getGroupMenu().visible = false;
      }
      
      private function getGroupMenu() : class_2261
      {
         return class_2261(_cont.findChildByName("menu_group"));
      }
      
      private function getGroupTypeRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("grouptype_" + param1 + "_radio"));
      }
      
      private function getGroupTypeSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("grouptype_selector"));
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
   }
}

