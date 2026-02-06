package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import com.sulake.habbo.communication.messages.outgoing.room.bots.CommandBotComposer;
   import com.sulake.habbo.communication.messages.parser.room.bots.class_3969;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveBotFromFlatMessageComposer;
   
   public class RentableBotMenuView extends AvatarContextInfoButtonView
   {
      
      protected var var_24:class_3025;
      
      public function RentableBotMenuView(param1:AvatarInfoWidget)
      {
         super(param1);
         var_236 = false;
      }
      
      public static function setup(param1:RentableBotMenuView, param2:int, param3:String, param4:int, param5:int, param6:class_3025) : void
      {
         param1.var_24 = param6;
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WME_OVER",onMouseHoverEvent);
            _window.removeEventListener("WME_OUT",onMouseHoverEvent);
         }
         var_24 = null;
         super.dispose();
      }
      
      protected function updateButtons() : void
      {
         var _loc6_:int = 0;
         if(!_window || !var_24)
         {
            return;
         }
         var _loc2_:IItemListWindow = _window.findChildByName("buttons") as IItemListWindow;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:class_1812 = var_34.getListItemByName("link_template") as class_1812;
         var _loc1_:class_1812 = var_34.getListItemByName("nux_proceed_1") as class_1812;
         _loc2_.procedure = buttonEventProc;
         _loc2_.autoArrangeItems = false;
         var _loc5_:int = _loc2_.numListItems;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_.getListItemAt(_loc6_).visible = false;
            _loc6_++;
         }
         var _loc7_:Boolean = var_24.amIOwner || var_24.amIAnyRoomController;
         showButton("pick",!var_24.botSkills ? _loc7_ : var_24.botSkills.indexOf(12) == -1 && _loc7_);
         if(var_24.botSkills)
         {
            showButton("donate_to_all",var_24.botSkills.indexOf(25) != -1);
            showButton("donate_to_user",var_24.botSkills.indexOf(24) != -1);
            if(var_24.amIOwner)
            {
               showButton("change_bot_name",var_24.botSkills.indexOf(5) != -1);
               showButton("dress_up",var_24.botSkills.indexOf(1) != -1);
               showButton("random_walk",var_24.botSkills.indexOf(3) != -1);
               showButton("setup_chat",var_24.botSkills.indexOf(2) != -1);
               showButton("dance",var_24.botSkills.indexOf(4) != -1);
            }
            showButton("nux_take_tour",var_24.botSkills.indexOf(10) != -1);
         }
         showButton("wired_inspect",widget.handler.container.userDefinedRoomEvents.showInspectButton());
         for each(var _loc8_ in var_24.botSkillsWithCommands)
         {
            if(_loc8_.id == 7)
            {
               var _loc4_:class_1812 = _loc3_.clone() as class_1812;
               var _loc9_:Array = _loc8_.data.split(",");
               if(_loc9_.length == 2)
               {
                  null.findChildByName("label").caption = null[0];
                  null.name = ":link " + null[1];
                  null.visible = true;
                  _loc2_.addListItem(null);
               }
            }
            if(_loc8_.id == 8)
            {
               if(_loc8_.data == "")
               {
                  showButton("nux_proceed_1",true);
               }
               else
               {
                  _loc9_ = _loc8_.data.split(",");
                  if(_loc9_.length == 2)
                  {
                     var _loc10_:int = parseInt(null[1]);
                     if(_loc10_ == 1)
                     {
                        showButton("nux_proceed_1",true);
                        class_1812(_loc2_.getListItemByName("nux_proceed_1")).findChildByName("label").caption = null[0];
                     }
                     else
                     {
                        _loc4_ = _loc1_.clone() as class_1812;
                        _loc4_.visible = true;
                        null.name = "nux_proceed_" + 0;
                        null.findChildByName("label").caption = null[0];
                        _loc2_.addListItemAt(null,_loc2_.getListItemIndex(_loc2_.getListItemByName("nux_proceed_1")) + 0 - 1);
                     }
                  }
               }
            }
            if(_loc8_.id == 14)
            {
               _loc4_ = _loc3_.clone() as class_1812;
               _loc9_ = _loc8_.data.split(",");
               if(_loc9_.length == 2)
               {
                  null.findChildByName("label").caption = null[0];
                  null.name = ":link navigator/search/" + null[1];
                  null.visible = true;
                  _loc2_.addListItem(null);
               }
            }
         }
         _loc2_.autoArrangeItems = true;
         _loc2_.visible = true;
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!var_16 || !var_16.assets || !var_16.windowManager)
         {
            return;
         }
         if(var_530)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(var_16.assets.getAssetByName("avatar_menu_widget")).content as XML;
               _window = var_16.windowManager.buildFromXML(_loc1_,0) as class_1812;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               _window.findChildByName("minimize").addEventListener("WME_CLICK",onMinimize);
               _window.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
               _window.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            }
            var_34 = _window.findChildByName("buttons") as IItemListWindow;
            var_34.procedure = buttonEventProc;
            _window.findChildByName("name").caption = _userName;
            _window.visible = false;
            activeView = _window;
            updateButtons();
         }
      }
      
      override protected function buttonEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:Point = null;
         var _loc5_:Rectangle = null;
         var _loc6_:RoomWidgetMessage = null;
         var _loc8_:String = null;
         var _loc7_:String = null;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc5_ = null;
               switch(param2.parent.name)
               {
                  case "pick":
                     _loc3_ = true;
                     widget.handler.container.connection.send(new RemoveBotFromFlatMessageComposer(var_24.id));
                     break;
                  case "setup_chat":
                     _loc3_ = true;
                     _loc5_ = new Rectangle();
                     _window.getGlobalRectangle(_loc5_);
                     _loc4_ = new Point(_loc5_.x + _loc5_.width / 2,_loc5_.y + _loc5_.height);
                     widget.openBotSkillConfigurationView(var_24.id,2,_loc4_);
                     break;
                  case "random_walk":
                     _loc3_ = true;
                     widget.handler.container.connection.send(new CommandBotComposer(var_24.id,3,""));
                     break;
                  case "dress_up":
                     _loc3_ = true;
                     widget.handler.container.connection.send(new CommandBotComposer(var_24.id,1,""));
                     break;
                  case "dance":
                     _loc3_ = true;
                     widget.handler.container.connection.send(new CommandBotComposer(var_24.id,4,""));
                     break;
                  case "donate_to_all":
                     _loc3_ = true;
                     widget.handler.container.connection.send(new CommandBotComposer(var_24.id,25,""));
                     break;
                  case "donate_to_user":
                     _loc3_ = true;
                     widget.handler.container.connection.send(new CommandBotComposer(var_24.id,24,""));
                     break;
                  case "nux_take_tour":
                     _loc3_ = true;
                     widget.component.context.createLinkEvent("help/tour");
                     widget.handler.container.connection.send(new CommandBotComposer(var_24.id,10,""));
                     break;
                  case "wired_inspect":
                     _loc3_ = true;
                     _loc6_ = new RoomWidgetUserActionMessage("RWUAM_WIRED_INSPECT_BOT",var_24.id);
                     widget.messageListener.processWidgetMessage(_loc6_);
                     break;
                  case "change_bot_name":
                     _loc3_ = true;
                     _loc5_ = new Rectangle();
                     _window.getGlobalRectangle(_loc5_);
                     _loc4_ = new Point(_loc5_.x + _loc5_.width / 2,_loc5_.y + _loc5_.height);
                     widget.openBotSkillConfigurationView(var_24.id,5,_loc4_);
               }
               if(param2.parent.name.indexOf(":link ") != -1)
               {
                  _loc8_ = param2.parent.name.substr(6,param2.parent.name.length - 6);
                  widget.component.context.createLinkEvent(_loc8_);
                  _loc3_ = true;
               }
               while(true)
               {
                  if(param2.parent.name.indexOf("nux_proceed_") != -1)
                  {
                     _loc7_ = param2.parent.name.substr(12,param2.parent.name.length - 12);
                     widget.handler.container.connection.send(new CommandBotComposer(var_24.id,8,_loc7_));
                     _loc3_ = true;
                  }
               }
               if(_loc3_)
               {
                  var_16.removeView(this,false);
               }
               return;
            }
            updateButtons();
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         §§goto(addr0307);
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return var_16 as AvatarInfoWidget;
      }
   }
}

