package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3786 extends class_3679
   {
      
      private var var_59:HabboUserDefinedRoomEvents;
      
      private var _cont:class_1812;
      
      private var initialHandItems:Array;
      
      public function class_3786()
      {
         super();
      }
      
      private static function getCodeInHandItemLoc(param1:String) : int
      {
         return parseInt(param1.substr(10,param1.length - 11));
      }
      
      override public function get code() : int
      {
         return class_4061.BOT_GIVE_HAND_ITEM;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         var_59 = param3;
         _cont = param1;
         initialHandItems = getHandItemMenu().enumerateSelection();
         getBotUsageCheckBox().addEventListener("WE_SELECT",onUseBot);
         getBotUsageCheckBox().addEventListener("WE_UNSELECT",onNotUseBot);
      }
      
      override public function readStringParamFromForm() : String
      {
         return getBotUsageCheckBox().isSelected ? getBotInput().text : "";
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getSelectedHandItemCode());
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:* = param1.stringParam != "";
         getBotInput().text = param1.stringParam;
         if(_loc2_)
         {
            getBotUsageCheckBox().select();
            getBotInput().visible = true;
         }
         else
         {
            getBotUsageCheckBox().unselect();
            getBotInput().visible = false;
         }
         setSelectedHandItemByCode(param1.intParams[0]);
         cont.findChildByName("capture_handitem").procedure = captureHanditem;
      }
      
      private function getSelectedHandItemCode() : int
      {
         var _loc2_:Array = getHandItemMenu().enumerateSelection();
         var _loc1_:int = getHandItemMenu().selection;
         if(_loc1_ == -1)
         {
            return 0;
         }
         return getCodeInHandItemLoc(_loc2_[_loc1_]);
      }
      
      private function setSelectedHandItemByCode(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = null;
         var _loc5_:class_2261 = getHandItemMenu();
         _loc5_.populate(initialHandItems);
         var _loc3_:Array = _loc5_.enumerateSelection();
         var _loc6_:int = -1;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(getCodeInHandItemLoc(_loc3_[_loc4_]) == param1)
            {
               _loc6_ = _loc4_;
            }
            _loc4_++;
         }
         if(_loc6_ == -1 && param1 >= 0)
         {
            _loc2_ = initialHandItems.concat();
            _loc2_.push("${handitem" + param1 + "}");
            _loc5_.populate(_loc2_);
            _loc6_ = _loc5_.numMenuItems - 1;
         }
         _loc5_.selection = _loc6_;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getBotInput() : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("bot_name"));
      }
      
      private function getHandItemMenu() : class_2261
      {
         return class_2261(_cont.findChildByName("menu_handitem"));
      }
      
      private function getBotUsageCheckBox() : class_1885
      {
         return class_1885(_cont.findChildByName("use_bot_checkbox"));
      }
      
      private function onUseBot(param1:class_1758) : void
      {
         getBotInput().visible = true;
      }
      
      private function onNotUseBot(param1:class_1758) : void
      {
         getBotInput().visible = false;
      }
      
      private function captureHanditem(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:int = 0;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = var_59.roomEngine.getRoomObject(this.var_59.roomSession.roomId,this.var_59.roomSession.ownUserRoomId,100).getModel().getNumber("figure_carry_object");
            setSelectedHandItemByCode(_loc3_);
         }
      }
   }
}

