package com.sulake.habbo.ui.widget.avatarinfo.botskills
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.outgoing.room.bots.CommandBotComposer;
   
   public class BotChangeNameConfiguration extends BotSkillConfigurationViewBase
   {
      
      private var _newName:String = "";
      
      public function BotChangeNameConfiguration(param1:AvatarInfoWidget)
      {
         super(param1);
      }
      
      override protected function get windowAssetName() : String
      {
         return "name_configuration_xml";
      }
      
      override protected function get skillType() : int
      {
         return 5;
      }
      
      override public function dispose() : void
      {
         close();
         super.dispose();
      }
      
      override public function open(param1:int, param2:Point = null) : void
      {
         super.open(param1,param2);
         _window.procedure = procedure;
      }
      
      override public function parseConfiguration(param1:String) : void
      {
         nameInput = param1;
      }
      
      private function set nameInput(param1:String) : void
      {
         _newName = param1;
         var _loc2_:ITextWindow = ITextWindow(_window.findChildByName("name_input"));
         _loc2_.text = _newName;
         _loc2_.activate();
      }
      
      override protected function deactivateInputs() : void
      {
         _window.findChildByName("name_input").deactivate();
      }
      
      private function procedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "save_button":
                  var_16.handler.container.connection.send(new CommandBotComposer(var_1504,5,_newName));
                  close();
                  break;
               case "cancel_button":
                  close();
            }
         }
         if(param1.type == "WKE_KEY_UP")
         {
            _newName = ITextWindow(_window.findChildByName("name_input")).text;
         }
      }
   }
}

