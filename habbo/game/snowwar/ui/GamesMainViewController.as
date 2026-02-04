package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class GamesMainViewController implements class_13
   {
      
      private static const INSTRUCTION_FRAME_LENGTH:int = 1000;
      
      private static const INSTRUCTION_ASSETS:Array = ["move_","throw_1_","throw_2_","throw_3_","balls_"];
      
      private static const INSTRUCTION_FRAME_COUNTS:Array = [4,4,5,5,5];
      
      private var var_49:SnowWarEngine;
      
      private var var_537:class_1812;
      
      private var var_30:class_1812;
      
      private var var_260:GameLobbyWindowCtrl;
      
      private var var_1134:Boolean;
      
      private var var_1072:SnowWarAnimatedWindowElement;
      
      private var var_1203:Timer;
      
      private var var_462:int = 0;
      
      private var var_322:int = 0;
      
      public function GamesMainViewController(param1:SnowWarEngine)
      {
         super();
         var_49 = param1;
      }
      
      public function get gameEngine() : SnowWarEngine
      {
         return var_49;
      }
      
      public function get rootWindow() : class_1812
      {
         return var_537;
      }
      
      public function get lobbyView() : GameLobbyWindowCtrl
      {
         return var_260;
      }
      
      public function toggleVisibility() : void
      {
         if(var_537)
         {
            var_537.visible = !rootWindow.visible;
         }
         else
         {
            openMainWindow(true);
         }
      }
      
      private function createWindow() : void
      {
         var_537 = WindowUtils.createWindow("games_main",1) as class_1812;
         var_537.findChildByTag("close").addEventListener("WME_CLICK",onClose);
         var_537.visible = true;
         var_537.center();
         var_30 = var_537.findChildByName("quick_play_container") as class_1812;
         var_30.findChildByName("play.button").addEventListener("WME_CLICK",onPlay);
         var_30.visible = false;
         var_30.findChildByName("instructions_link").addEventListener("WME_CLICK",onInstructions);
         var_30.findChildByName("leaderboard_link").addEventListener("WME_CLICK",onLeaderboard);
         var_30.findChildByName("instructions_back").addEventListener("WME_CLICK",onBack);
         var_30.findChildByName("instructions_next").addEventListener("WME_CLICK",onNext);
         var_30.findChildByName("instructions_prev").addEventListener("WME_CLICK",onPrevious);
         var_30.findChildByName("games_vip_region").addEventListener("WME_CLICK",onOpenClubCenter);
         var_30.procedure = windowEventProc;
         var_30.findChildByName("leaderboard_link").visible = var_49.config.getBoolean("games.highscores.enabled");
         var _loc2_:IItemListWindow = var_30.findChildByName("page_list") as IItemListWindow;
         var _loc1_:int = 0;
         while(0 < _loc2_.numListItems)
         {
            _loc2_.getListItemAt(0).addEventListener("WME_CLICK",onSelectPage);
            _loc1_++;
         }
         var_1134 = false;
         updateGameStartingStatus();
      }
      
      private function windowEventProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_OVER" || param1.type == "WME_OUT")
         {
            switch(param2.name)
            {
               case "btn_more_games_10":
                  WindowUtils.setElementImage(param2,getBitmap("btn_more_games_10" + (param1.type == "WME_OVER" ? "_hi" : "")));
                  break;
               case "btn_more_games_100":
                  WindowUtils.setElementImage(param2,getBitmap("btn_more_games_100" + (param1.type == "WME_OVER" ? "_hi" : "")));
                  break;
               case "btn_more_games_300":
                  WindowUtils.setElementImage(param2,getBitmap("btn_more_games_300" + (param1.type == "WME_OVER" ? "_hi" : "")));
            }
         }
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "btn_more_games_10":
                  var_49.catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS");
                  var_49.logGameEvent("gameFramework.buyTokens.clicked.frontView");
                  break;
               case "btn_more_games_100":
                  var_49.catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS2");
                  var_49.logGameEvent("gameFramework.buyTokens.clicked.frontView");
                  break;
               case "btn_more_games_300":
                  var_49.catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS3");
                  var_49.logGameEvent("gameFramework.buyTokens.clicked.frontView");
            }
         }
      }
      
      public function close(param1:Boolean) : void
      {
         if(var_260 && var_260.visible)
         {
            var_260.onClose(param1);
         }
         disposeViews();
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         close(true);
      }
      
      private function onPlay(param1:WindowMouseEvent) : void
      {
         if(var_49.freeGamesLeft != 0)
         {
            var_49.startQuickServerGame();
         }
         else
         {
            var_49.openGetMoreGames("gameFramework.onPlay.clicked.frontView");
         }
      }
      
      private function updateGettingMoreGamesOption() : void
      {
         var _loc1_:class_1741 = var_30.findChildByName("play.button");
         if(var_49.freeGamesLeft == 0)
         {
            _loc1_.visible = false;
         }
         else
         {
            _loc1_.visible = true;
         }
      }
      
      private function onInstructions(param1:WindowMouseEvent) : void
      {
         showInstructions(true);
      }
      
      private function onLeaderboard(param1:WindowMouseEvent) : void
      {
         var_49.showLeaderboard();
      }
      
      private function onBack(param1:WindowMouseEvent) : void
      {
         showInstructions(false);
      }
      
      private function onNext(param1:WindowMouseEvent) : void
      {
         var_322 = var_322 + 1;
         var_322 %= INSTRUCTION_ASSETS.length;
         showInstructions(true);
      }
      
      private function onPrevious(param1:WindowMouseEvent) : void
      {
         var_322 = var_322 - 1 + INSTRUCTION_ASSETS.length;
         var_322 %= INSTRUCTION_ASSETS.length;
         showInstructions(true);
      }
      
      private function onSelectPage(param1:WindowMouseEvent) : void
      {
         var_322 = parseInt(param1.window.name.replace("page_",""));
         showInstructions(true);
      }
      
      private function showInstructions(param1:Boolean) : void
      {
         var_30.findChildByName("teaser_container").visible = !param1;
         var_30.findChildByName("instructions_container").visible = param1;
         if(var_1072)
         {
            var_1072.dispose();
            var_1072 = null;
         }
         if(!param1)
         {
            return;
         }
         var _loc4_:class_2251 = var_30.findChildByName("instructions_image") as class_2251;
         var _loc6_:String = INSTRUCTION_ASSETS[var_322];
         var _loc2_:int = int(INSTRUCTION_FRAME_COUNTS[var_322]);
         var_1072 = new SnowWarAnimatedWindowElement(var_49.assets,_loc4_,_loc6_,_loc2_,1000);
         var_30.findChildByName("instruction_text").caption = "${snowwar.instructions." + (var_322 + 1) + "}";
         var _loc5_:IItemListWindow = var_30.findChildByName("page_list") as IItemListWindow;
         var _loc3_:int = 0;
         while(0 < _loc5_.numListItems)
         {
            var _loc7_:class_1812 = _loc5_.getListItemAt(0) as class_1812;
            _loc6_ = 0 <= var_322 ? "pagination_ball_hilite" : "pagination_ball";
            WindowUtils.setElementImage(null.getChildAt(0),getBitmap(_loc6_));
            _loc3_++;
         }
      }
      
      private function getBitmap(param1:String) : BitmapData
      {
         var _loc2_:IAsset = var_49.assets.getAssetByName(param1);
         if(_loc2_)
         {
            return _loc2_.content as BitmapData;
         }
         return null;
      }
      
      private function onOpenClubCenter(param1:WindowMouseEvent) : void
      {
         var_49.openClubCenter("gameFramework.getVip.clicked.frontView");
      }
      
      public function openMainWindow(param1:Boolean) : void
      {
         if(!var_537 && param1)
         {
            createWindow();
         }
         else if(!rootWindow && !param1)
         {
            return;
         }
         if(var_260)
         {
            var_260.visible = false;
         }
         var_30.visible = true;
      }
      
      public function openGameLobbyWindow(param1:String, param2:int, param3:int) : void
      {
         if(!var_537)
         {
            createWindow();
         }
         if(!var_260)
         {
            var_260 = new GameLobbyWindowCtrl(this,param1,param2,param3);
         }
         else
         {
            var_260.levelName = param1;
            var_260.numberOfTeams = param2;
            var_260.maxNumberOfPlayers = param3;
            var_260.clearPlayerList();
         }
         var_30.visible = false;
         var_260.visible = true;
      }
      
      public function dispose() : void
      {
         if(!var_1134)
         {
            disposeViews();
            var_1134 = true;
            disposeCounter();
         }
      }
      
      private function disposeViews() : void
      {
         if(var_1072)
         {
            var_1072.dispose();
            var_1072 = null;
         }
         if(var_260)
         {
            var_260.dispose();
            var_260 = null;
         }
         if(var_30)
         {
            var_30.dispose();
            var_30 = null;
         }
         if(var_537)
         {
            var_537.dispose();
            var_537 = null;
         }
      }
      
      private function disposeCounter() : void
      {
         if(var_1203)
         {
            var_1203.removeEventListener("timer",onTick);
            var_1203.stop();
            var_1203 = null;
         }
         var_462 = NaN;
      }
      
      public function get gameLobbyWindowActive() : Boolean
      {
         return var_260 && var_260.visible;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function updateGameStartingStatus() : void
      {
         var _loc1_:class_1812 = null;
         var _loc3_:ITextWindow = null;
         var _loc2_:class_1741 = null;
         if(var_30 && var_30.visible)
         {
            WindowUtils.setCaption(var_30.findChildByName("games_left"),var_49.freeGamesLeft.toString());
            _loc1_ = var_30.findChildByName("games_left_region") as class_1812;
            _loc3_ = var_30.findChildByName("games_left_stroke") as ITextWindow;
            _loc2_ = var_30.findChildByName("play.button");
            _loc2_.visible = true;
            updateGettingMoreGamesOption();
            if(checkGameAmountStatus(_loc1_,_loc3_,_loc2_))
            {
               checkBlockStatus(_loc2_);
            }
         }
      }
      
      private function checkGameAmountStatus(param1:class_1812, param2:ITextWindow, param3:class_1741) : Boolean
      {
         if(var_49.hasUnlimitedGames)
         {
            param1.visible = false;
            return true;
         }
         param1.visible = true;
         var _loc4_:class_1741 = ITextWindow(var_30.findChildByName("play_text"));
         param3.color = 5622784;
         switch(var_49.freeGamesLeft - -1)
         {
            case 0:
               param1.visible = false;
               WindowUtils.setCaption(_loc4_,"${snowwar.play}");
               return true;
            case 1:
               param1.visible = true;
               param2.textColor = 16711680;
               WindowUtils.setCaption(_loc4_,"${catalog.vip.buy.title}");
               return false;
            default:
               param1.visible = true;
               param2.textColor = 1079212;
               WindowUtils.setCaption(_loc4_,"${snowwar.play}");
               return true;
         }
      }
      
      private function checkBlockStatus(param1:class_1741) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:class_1741 = ITextWindow(var_30.findChildByName("play_text"));
         if(var_462 > 0)
         {
            param1.disable();
            param1.color = 13421772;
            _loc3_ = Math.floor(var_462 / 60);
            _loc2_ = var_462 % 60;
            _loc4_.caption = _loc3_ + ":" + (_loc2_ < 10 ? "0" + _loc2_ : _loc2_);
         }
         else if(var_462 <= 0)
         {
            param1.enable();
            param1.color = 5622784;
            WindowUtils.setCaption(_loc4_,"${snowwar.play}");
         }
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(var_462 && var_462 > 0)
         {
            var_462 = var_462 - 1;
            HabboGamesCom.log("on block tick " + var_462);
            updateGameStartingStatus();
         }
         if(var_462 <= 0)
         {
            updateGameStartingStatus();
            disposeCounter();
         }
      }
      
      public function changeBlockStatus(param1:int) : void
      {
         if(param1 > 0)
         {
            var_462 = param1;
            if(!var_1203)
            {
               var_1203 = new Timer(1000,var_462);
               var_1203.addEventListener("timer",onTick);
               var_1203.start();
            }
         }
         updateGameStartingStatus();
      }
   }
}

