package com.sulake.habbo.ui.widget.avatarinfo.botskills
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import com.sulake.habbo.communication.messages.incoming.room.bots.BotCommandConfigurationEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.bots.GetBotCommandConfigurationDataComposer;
   
   public class BotSkillConfigurationViewBase implements class_2534
   {
      
      private var var_1601:IMessageEvent;
      
      protected var var_16:AvatarInfoWidget;
      
      protected var _window:class_1812;
      
      protected var var_1504:int;
      
      public function BotSkillConfigurationViewBase(param1:AvatarInfoWidget)
      {
         super();
         var_16 = param1;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_16)
         {
            if(var_16.handler.container.connection && var_1601)
            {
               var_16.handler.container.connection.removeMessageEvent(var_1601);
               var_1601 = null;
            }
            var_16 = null;
         }
         var_1504 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return var_16 == null;
      }
      
      public function open(param1:int, param2:Point = null) : void
      {
         var_1504 = param1;
         if(!var_1601)
         {
            var_1601 = new BotCommandConfigurationEvent(onBotCommandConfigurationEvent);
            var_16.handler.container.connection.addMessageEvent(var_1601);
         }
         var_16.handler.container.connection.send(new GetBotCommandConfigurationDataComposer(var_1504,skillType));
         if(!_window)
         {
            var _loc3_:XML = var_16.assets.getAssetByName(windowAssetName).content as XML;
            _window = var_16.windowManager.buildFromXML(null,1) as class_1812;
         }
         if(param2)
         {
            var _loc4_:Rectangle = _window.rectangle;
            _window.x = param2.x - null.width / 2;
            _window.y = param2.y - null.height;
         }
         fitToScreen();
         _window.visible = true;
         deactivateInputs();
      }
      
      public function close() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function parseConfiguration(param1:String) : void
      {
      }
      
      protected function deactivateInputs() : void
      {
      }
      
      protected function get windowAssetName() : String
      {
         return "";
      }
      
      protected function get skillType() : int
      {
         return -1;
      }
      
      private function onBotCommandConfigurationEvent(param1:BotCommandConfigurationEvent) : void
      {
         if(param1.getParser().botId == var_1504 && param1.getParser().commandId == skillType)
         {
            parseConfiguration(param1.getParser().data);
         }
      }
      
      private function fitToScreen() : void
      {
         var _loc1_:Rectangle = new Rectangle();
         _window.getGlobalRectangle(_loc1_);
         if(_loc1_.top < 0)
         {
            _window.y += -_loc1_.top;
         }
         if(_loc1_.left < 0)
         {
            _window.x += -_loc1_.left;
         }
         if(_loc1_.right > _window.desktop.width)
         {
            _window.x -= _loc1_.right - _window.desktop.width;
         }
         if(_loc1_.bottom > _window.desktop.height)
         {
            _window.y -= _loc1_.bottom - _window.desktop.height;
         }
      }
   }
}

