package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyPlayerData;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import com.sulake.habbo.localization.class_27;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2LeaveGameMessageComposer;
   
   public class GameLobbyWindowCtrl implements class_13, class_259
   {
      
      private var var_172:GamesMainViewController;
      
      private var var_49:SnowWarEngine;
      
      private var _levelName:String;
      
      private var _numberOfTeams:int;
      
      private var _numberOfPlayers:int;
      
      private var _maxNumberOfPlayers:int;
      
      private var var_393:class_1812;
      
      private var var_1457:Timer;
      
      private var var_493:int = -1;
      
      private var var_1353:int = -1;
      
      private var var_1134:Boolean = false;
      
      private var var_1135:class_55;
      
      private var var_838:class_55;
      
      public function GameLobbyWindowCtrl(param1:GamesMainViewController, param2:String, param3:int, param4:int)
      {
         super();
         var_172 = param1;
         var_49 = param1.gameEngine;
         var_1135 = new class_55();
         var_838 = new class_55();
         _levelName = param2;
         _numberOfTeams = param3;
         _numberOfPlayers = numberOfPlayers;
         _maxNumberOfPlayers = param4;
      }
      
      private function createLobbyView() : void
      {
         var_393 = var_172.rootWindow.findChildByName("snowwar_lobby_cont") as class_1812;
         var_393.center();
         var_393.findChildByName("cancel_link_region").procedure = onCancel;
         var _loc2_:IItemGridWindow = var_393.findChildByName("players_grid") as IItemGridWindow;
         var _loc4_:class_1812 = WindowUtils.createWindow("snowwar_lobby_player") as class_1812;
         var _loc3_:int = 0;
         while(0 < _maxNumberOfPlayers)
         {
            _loc2_.addGridItem(_loc4_.clone());
            _loc3_++;
         }
         _loc4_.dispose();
         var_393.visible = false;
      }
      
      private function createWindow(param1:String) : class_1812
      {
         var _loc2_:XmlAsset = var_49.assets.getAssetByName(param1) as XmlAsset;
         return var_49.windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
      }
      
      private function onCancel(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         onClose(true);
         if(!var_49.gameCenterEnabled)
         {
            var_172.openMainWindow(true);
         }
         else
         {
            var_172.close(true);
         }
      }
      
      public function onClose(param1:Boolean) : void
      {
         if(param1)
         {
            var_49.communication.connection.send(new Game2LeaveGameMessageComposer());
         }
         disposeCountdownTimer();
         var_1353 = -1;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(!var_393)
         {
            createLobbyView();
         }
         var_393.visible = param1;
      }
      
      public function get visible() : Boolean
      {
         if(var_393)
         {
            return var_393.visible;
         }
         return false;
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         if(var_838)
         {
            for each(var _loc1_ in var_838)
            {
               _loc1_.dispose();
            }
            var_838.dispose();
            var_838 = null;
         }
         if(var_393 != null)
         {
            var_393.dispose();
            var_393 = null;
         }
         disposeCountdownTimer();
         if(var_1135)
         {
            var_1135.dispose();
            var_1135 = null;
         }
         var_1353 = -1;
      }
      
      private function disposeCountdownTimer() : void
      {
         if(var_1457 != null)
         {
            var_1457.removeEventListener("timer",onTick);
            var_1457.stop();
            var_1457 = null;
         }
         var_493 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function playerLeft(param1:int) : void
      {
         var_1135.remove(param1);
         updateDialog(true);
      }
      
      public function playerJoined(param1:GameLobbyPlayerData) : void
      {
         if(param1)
         {
            var_1135.add(param1.userId,param1);
            updateDialog(true,param1.figure);
         }
      }
      
      public function clearPlayerList() : void
      {
         var_1135.reset();
      }
      
      public function startCountdown(param1:int) : void
      {
         disposeCountdownTimer();
         var_493 = param1;
         var_1457 = new Timer(1000,param1);
         var_1457.addEventListener("timer",onTick);
         var_1457.start();
         updateDialog(false);
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(var_1134)
         {
            return;
         }
         if(var_493 && var_493 > 0)
         {
            var_493 = var_493 - 1;
            HabboGamesCom.log("on tick " + var_493);
            updateDialog(false);
         }
      }
      
      public function stopCountdown() : void
      {
         disposeCountdownTimer();
         updateDialog(false);
      }
      
      public function set queuePosition(param1:int) : void
      {
         var_1353 = param1;
      }
      
      private function updateDialog(param1:Boolean, param2:String = null) : void
      {
         var _loc16_:String = null;
         var _loc13_:* = null;
         var _loc9_:IRegionWindow = null;
         var _loc8_:class_2251 = null;
         var _loc15_:SnowWarAnimatedWindowElement = null;
         var _loc10_:class_1827 = null;
         var _loc4_:BitmapData = null;
         var _loc6_:Point = null;
         var _loc14_:class_1741 = var_393.findChildByName("wait_text") as ITextWindow;
         var _loc5_:class_1741 = var_393.findChildByName("wait_text_stroke") as ITextWindow;
         var _loc3_:class_27 = var_49.localization;
         if(var_493 >= 0)
         {
            _loc16_ = "snowwar.lobby_game_start_countdown";
            _loc3_.registerParameter(_loc16_,"seconds",String(var_493));
            _loc13_ = _loc16_ + " " + "%seconds%" + " " + var_493;
         }
         else if(var_1353 >= 0)
         {
            _loc16_ = "snowwar.lobby_arena_queue_position";
            _loc3_.registerParameter(_loc16_,"position",String(var_1353));
            _loc13_ = _loc16_ + " " + "%position%" + " " + var_1353;
         }
         else
         {
            _loc13_ = _loc16_ = "snowwar.lobby_waiting_for_more_players";
         }
         var _loc11_:String = _loc3_.getLocalization(_loc16_);
         if(_loc11_)
         {
            _loc14_.caption = _loc11_;
            _loc5_.caption = _loc11_;
         }
         else
         {
            _loc14_.caption = _loc13_;
            _loc5_.caption = _loc13_;
         }
         var _loc7_:int = 0;
         var _loc12_:IItemGridWindow = var_393.findChildByName("players_grid") as IItemGridWindow;
         if(param1)
         {
            for each(var _loc17_ in var_1135.getValues())
            {
               _loc10_ = null;
               if(_loc17_.figure == param2 || !param2)
               {
                  _loc10_ = var_49.avatarManager.createAvatarImage(_loc17_.figure,"h",_loc17_.gender,this);
               }
               if(_loc10_)
               {
                  _loc10_.setDirection("head",2);
                  _loc4_ = _loc10_.getCroppedImage("head");
                  _loc9_ = _loc12_.getGridItemAt(_loc7_) as IRegionWindow;
                  if(_loc9_)
                  {
                     _loc9_.toolTipCaption = _loc17_.name;
                     _loc9_.mouseThreshold = 0;
                     _loc8_ = _loc9_.findChildByName("image") as class_2251;
                     _loc15_ = var_838.remove(_loc8_);
                     if(_loc15_)
                     {
                        _loc15_.dispose();
                     }
                     if(_loc8_.bitmap)
                     {
                        _loc8_.bitmap.dispose();
                     }
                     _loc8_.bitmap = new BitmapData(_loc8_.width,_loc8_.height,true,0);
                     _loc6_ = new Point((_loc8_.width - _loc4_.width) / 2,(_loc8_.height - _loc4_.height) / 2);
                     _loc8_.bitmap.copyPixels(_loc4_,_loc4_.rect,_loc6_);
                  }
                  _loc4_.dispose();
                  _loc10_.dispose();
               }
               _loc7_++;
            }
            while(_loc7_ < maxNumberOfPlayers)
            {
               _loc9_ = _loc12_.getGridItemAt(_loc7_) as IRegionWindow;
               _loc8_ = _loc9_.findChildByName("image") as class_2251;
               if(!var_838.hasKey(_loc8_))
               {
                  _loc15_ = new SnowWarAnimatedWindowElement(var_49.assets,_loc8_,"load_",8);
                  var_838.add(_loc8_,_loc15_);
               }
               _loc7_++;
            }
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         updateDialog(true,param1);
      }
      
      public function get levelName() : String
      {
         return _levelName;
      }
      
      public function get numberOfTeams() : int
      {
         return _numberOfTeams;
      }
      
      public function get numberOfPlayers() : int
      {
         return _numberOfPlayers;
      }
      
      public function get maxNumberOfPlayers() : int
      {
         return _maxNumberOfPlayers;
      }
      
      public function set levelName(param1:String) : void
      {
         _levelName = param1;
      }
      
      public function set maxNumberOfPlayers(param1:int) : void
      {
         _maxNumberOfPlayers = param1;
      }
      
      public function set numberOfTeams(param1:int) : void
      {
         _numberOfTeams = param1;
      }
      
      public function set numberOfPlayers(param1:int) : void
      {
         _numberOfPlayers = param1;
      }
      
      public function set counter(param1:int) : void
      {
         var_493 = param1;
      }
   }
}

