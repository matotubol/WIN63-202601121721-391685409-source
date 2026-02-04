package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.window.widgets.class_2478;
   
   public class class_3919 extends class_3679
   {
      
      private static const STRING_PARAM_DELIMITER:String = "\t";
      
      private var var_59:HabboUserDefinedRoomEvents;
      
      private var _figureString:String;
      
      private var _botName:String;
      
      private var _window:class_1812;
      
      public function class_3919()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4061.BOT_CHANGE_FIGURE;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         var_59 = param3;
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc1_:String = getInput(cont,"bot_name").text;
         return _loc1_ + "\t" + _figureString;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:Array = param1.stringParam.split("\t");
         if(_loc2_.length > 0)
         {
            _botName = _loc2_[0];
         }
         if(_loc2_.length > 1)
         {
            _figureString = _loc2_[1];
         }
         getInput(cont,"bot_name").text = _botName;
         class_2478(class_2010(cont.findChildByName("avatar_image")).widget).figure = _figureString;
         cont.findChildByName("capture_figure").procedure = captureFigureButtonProcedure;
         _window = cont;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:class_1812, param2:String) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName(param2));
      }
      
      private function captureFigureButtonProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _figureString = var_59.sessionDataManager.figure;
            class_2478(class_2010(_window.findChildByName("avatar_image")).widget).figure = _figureString;
         }
      }
   }
}

