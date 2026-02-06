package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_1900;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2GameResult;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2SnowWarGameStats;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2TeamPlayerData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2TeamScoreData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyPlayerData;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2ExitGameMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2GetAccountGameStatusMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2LeaveGameMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   
   public class GameEndingViewController implements class_13, class_259
   {
      
      private static const NUMBER_OF_TEAMS:uint = 2;
      
      private static const STATE_RESULTS:int = 0;
      
      private static const STATE_RESULTS_PENDING_REMATCH:int = 1;
      
      private static const STATE_WAITING:int = 2;
      
      private static const STATE_LOBBY:int = 3;
      
      private static const STATE_LOADING:int = 4;
      
      private static const STATE_AFTER_SKI:int = 5;
      
      private static const const_1073:int = 1;
      
      private var _window:class_1812;
      
      private var var_49:SnowWarEngine;
      
      private var var_1134:Boolean = false;
      
      private var _teams:Array;
      
      private var _players:Dictionary;
      
      private var var_1860:BackgroundViewController;
      
      private var var_1995:Game2GameResult;
      
      private var var_1457:Timer;
      
      private var var_493:int = 0;
      
      private var var_61:int = 0;
      
      private var _lobbyPlayers:class_55;
      
      private var var_793:class_55;
      
      private var var_5287:int = 1;
      
      public function GameEndingViewController(param1:SnowWarEngine, param2:Array, param3:Game2SnowWarGameStats, param4:Game2GameResult, param5:int)
      {
         super();
         _teams = param2;
         _players = new Dictionary();
         var_49 = param1;
         var_1995 = param4;
         var_793 = new class_55();
         param1.roomUI.visible = false;
         param1.windowManager.getDesktop(1).visible = false;
         var_1860 = new BackgroundViewController(var_49);
         var_1860.background.visible = true;
         createMainView();
         for each(var _loc6_ in param2)
         {
            addTeamScores(_loc6_);
         }
         var _loc7_:ITextWindow = getElement(_window,"endingInformation") as ITextWindow;
         if(var_1995.resultType == 2)
         {
            WindowUtils.colorStrokes(_loc7_.parent,getNeutralTeamColor());
            WindowUtils.setCaption(_loc7_,"${snowwar.result.tie}");
         }
         else
         {
            WindowUtils.colorStrokes(_loc7_.parent,getTeamColor(var_1995.winnerId));
            WindowUtils.setCaption(_loc7_,"${snowwar.team_" + var_1995.winnerId + "_wins}");
         }
         showMostHits(param3.playerWithMostHits);
         showMostKills(param3.playerWithMostKills);
         startResultsCountDown(param5);
         if(var_49.hasUnlimitedGames)
         {
            WindowUtils.hideElement(_window,"statusContainer");
         }
         else
         {
            WindowUtils.showElement(_window,"statusContainer");
            var_49.communication.connection.send(new Game2GetAccountGameStatusMessageComposer(0));
         }
         updateGamesLeft();
      }
      
      public function dispose() : void
      {
         var_49.windowManager.getDesktop(1).visible = true;
         disposeCountDownTimer();
         if(var_793)
         {
            for each(var _loc1_ in var_793)
            {
               _loc1_.dispose();
            }
            var_793.dispose();
            var_793 = null;
         }
         if(var_1860)
         {
            var_1860.dispose();
            var_1860 = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _teams = null;
         _players = null;
         var_1995 = null;
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      private function createMainView() : void
      {
         _window = WindowUtils.createWindow("snowwar_ending") as class_1812;
         _window.x = (_window.desktop.width - _window.width) / 2;
         _window.y = _window.desktop.height > 685 ? 115 : 10;
         _window.findChildByName("leave_link_region").procedure = onCancel;
         _window.findChildByName("button_rematch").addEventListener("WME_CLICK",onJoinRematch);
         _window.findChildByName("button_play_again").addEventListener("WME_CLICK",onPlayAgain);
         _window.findChildByName("button_buy_games").addEventListener("WME_CLICK",onBuyMoreGames);
         _window.findChildByName("loadingContainer").visible = false;
         _window.findChildByName("statusContainer").addEventListener("WME_CLICK",onGetMore);
      }
      
      private function onJoinRematch(param1:WindowMouseEvent = null, param2:class_1741 = null) : void
      {
         if(var_49.freeGamesLeft == 0)
         {
            onGetMore(param1);
         }
         else
         {
            var_61 = 1;
            var_49.sendRejoinGame();
            var _loc3_:class_1741 = _window.findChildByName("button_rematch");
            null.color = 13421772;
            null.disable();
            _window.findChildByName("statusContainer").visible = false;
         }
      }
      
      private function onPlayAgain(param1:class_1758 = null, param2:class_1741 = null) : void
      {
         var_49.startQuickServerGame();
         _window.findChildByName("button_play_again").visible = false;
         _window.findChildByName("statusContainer").visible = false;
      }
      
      private function onBuyMoreGames(param1:WindowMouseEvent) : void
      {
         onGetMore(param1);
      }
      
      private function updateGettingMoreGamesOption() : void
      {
         var _loc2_:class_1741 = _window.findChildByName("button_rematch");
         var _loc1_:class_1741 = _window.findChildByName("button_buy_games");
         var _loc3_:class_1741 = _window.findChildByName("status.text_get_vip");
         var _loc4_:class_1741 = _window.findChildByName("status.text_get_more_games");
         _loc2_.visible = false;
         _loc1_.visible = false;
         _loc3_.visible = false;
         _loc4_.visible = false;
         switch(var_5287 - 1)
         {
            case 0:
               if(var_49.freeGamesLeft == 0)
               {
                  _loc1_.visible = true;
               }
               else
               {
                  _loc2_.visible = true;
               }
               _loc4_.visible = true;
               break;
            default:
               _loc2_.visible = true;
               _loc3_.visible = true;
         }
      }
      
      private function onCancel(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         onClose(true);
      }
      
      public function onClose(param1:Boolean) : void
      {
         if(param1)
         {
            var_49.gameCancelled(true);
            if(var_61 == 3 || var_61 == 2)
            {
               var_49.communication.connection.send(new Game2LeaveGameMessageComposer());
               if(var_49.roomBeforeGame > -1)
               {
                  var_49.communication.connection.send(new GetGuestRoomMessageComposer(var_49.roomBeforeGame,false,true));
               }
            }
            else if(var_61 == 5)
            {
               if(var_49.roomBeforeGame > -1)
               {
                  var_49.communication.connection.send(new GetGuestRoomMessageComposer(var_49.roomBeforeGame,false,true));
               }
               else
               {
                  var_49.communication.connection.send(new Game2ExitGameMessageComposer());
               }
            }
            else
            {
               var_49.communication.connection.send(new Game2ExitGameMessageComposer());
            }
            disposeCountDownTimer();
         }
      }
      
      private function disposeCountDownTimer() : void
      {
         if(var_1457)
         {
            var_1457.removeEventListener("timer",onTick);
            var_1457.stop();
            var_1457 = null;
            var_493 = 0;
         }
      }
      
      private function addTeamScores(param1:Game2TeamScoreData) : void
      {
         var _loc2_:int = param1.teamReference;
         for each(var _loc3_ in param1.players)
         {
            addPlayerScore(_loc3_);
         }
         WindowUtils.setCaption(getElement(_window,"team" + _loc2_ + "Score"),param1.score.toString());
      }
      
      private function addPlayerScore(param1:Game2TeamPlayerData) : void
      {
         _players[param1.userId] = param1;
         var _loc6_:IItemListWindow = _window.findChildByName("team" + param1.teamId + "PlayersList") as IItemListWindow;
         var _loc5_:IItemListWindow = WindowUtils.createWindow("snowwar_results_player_team_" + param1.teamId) as IItemListWindow;
         var _loc7_:class_1812 = _loc5_.getListItemByName("playerImageContainer") as class_1812;
         var _loc4_:class_1812 = _loc5_.getListItemByName("playerDataContainer") as class_1812;
         var _loc2_:class_1812 = _loc5_.getListItemByName("playerScoreContainer") as class_1812;
         WindowUtils.setElementImage(getElement(_loc7_,"playerImage"),getAvatarFigure(param1.teamId,param1.figure,param1.gender),0,0,0);
         WindowUtils.setCaption(getElement(_loc4_,"playerName"),param1.userName);
         WindowUtils.hideElement(_loc4_,"playerTotalStats");
         WindowUtils.setCaption(getElement(_loc4_,"playerHits"),param1.playerStats.snowballHits.toString());
         WindowUtils.setCaption(getElement(_loc4_,"playerKills"),param1.playerStats.kills.toString());
         WindowUtils.setCaption(getElement(_loc2_,"playerScore"),param1.score.toString());
         var _loc3_:class_1812 = _loc7_.findChildByName("addFriend") as class_1812;
         if(var_49.friendList.canBeAskedForAFriend(param1.userId) && param1.userId != var_49.sessionDataManager.userId)
         {
            _loc3_.id = param1.userId;
            _loc3_.getChildAt(0).id = param1.teamId;
            _loc3_.addEventListener("WME_CLICK",onAddFriendClick);
            _loc3_.addEventListener("WME_OVER",onAddFriendOver);
            _loc3_.addEventListener("WME_OUT",onAddFriendOut);
            _loc3_.visible = true;
         }
         _loc6_.addListItem(_loc5_);
         _loc5_.name = "player" + param1.userId;
      }
      
      private function onAddFriendClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = param1.window.id;
         var _loc3_:Game2TeamPlayerData = _players[_loc2_];
         if(_loc3_)
         {
            var_49.friendList.askForAFriend(_loc2_,_loc3_.userName);
            var_49.communication.connection.send(new EventLogMessageComposer("GameFramework","SnowStorm","gameFramework.sendFriendRequest.rematchView"));
            var_49.addChatMessage(_loc2_,"${snowwar.friend_request.sent}",true);
         }
         param1.window.visible = false;
      }
      
      private function onAddFriendOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1741 = (param1.window as class_1812).getChildAt(0);
         WindowUtils.setElementImage(_loc2_,getBitmap("add_friend_icon_green"));
      }
      
      private function onAddFriendOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1741 = (param1.window as class_1812).getChildAt(0);
         var _loc3_:String = "add_friend_icon_" + (_loc2_.id == 1 ? "blue" : "red");
         WindowUtils.setElementImage(_loc2_,getBitmap(_loc3_));
      }
      
      private function showMostHits(param1:int) : void
      {
         var _loc3_:Game2TeamPlayerData = _players[param1];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_1812 = _window.findChildByName("mostHitsContainer") as class_1812;
         if(_loc3_.playerStats.snowballHits == 0)
         {
            _loc2_.visible = false;
            return;
         }
         WindowUtils.setElementImage(getElement(_loc2_,"backgroundImage"),getBitmap(getPlayerImageBackground(_loc3_.teamId)));
         WindowUtils.setElementImage(getElement(_loc2_,"playerImage"),getAvatarFigure(_loc3_.teamId,_loc3_.figure,_loc3_.gender),0,0,0);
         WindowUtils.setCaption(getElement(_loc2_,"playerName"),_loc3_.userName);
         WindowUtils.colorStrokes(_loc2_,getTeamColor(_loc3_.teamId));
      }
      
      private function showMostKills(param1:int) : void
      {
         var _loc3_:Game2TeamPlayerData = _players[param1];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_1812 = _window.findChildByName("mostKillsContainer") as class_1812;
         if(_loc3_.playerStats.kills == 0)
         {
            _loc2_.visible = false;
            return;
         }
         WindowUtils.setElementImage(getElement(_loc2_,"backgroundImage"),getBitmap(getPlayerImageBackground(_loc3_.teamId)));
         WindowUtils.setElementImage(getElement(_loc2_,"playerImage"),getAvatarFigure(_loc3_.teamId,_loc3_.figure,_loc3_.gender),0,0,0);
         WindowUtils.setCaption(getElement(_loc2_,"playerName"),_loc3_.userName);
         WindowUtils.colorStrokes(_loc2_,getTeamColor(_loc3_.teamId));
      }
      
      private function getPlayerImageBackground(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = "blue_square";
               break;
            case 1:
               _loc2_ = "red_square";
               break;
            default:
               _loc2_ = "blue_square";
         }
         return _loc2_;
      }
      
      private function getNeutralTeamColor() : uint
      {
         return 8227482;
      }
      
      private function getTeamColor(param1:int) : uint
      {
         switch(param1 - 1)
         {
            case 0:
               return 4279269292;
            case 1:
               return 4294797401;
            default:
               return 4279269292;
         }
      }
      
      private function getTeamPlayerDirection(param1:int) : uint
      {
         switch(param1 - 1)
         {
            case 0:
               return 2;
            case 1:
               return 4;
            default:
               return 2;
         }
      }
      
      private function getAvatarFigure(param1:int, param2:String, param3:String) : BitmapData
      {
         var _loc4_:class_1900 = var_49.avatarManager.createFigureContainer(param2);
         switch(param1 - 1)
         {
            case 0:
               _loc4_.updatePart("ch",20000,[1]);
               break;
            case 1:
               _loc4_.updatePart("ch",20001,[1]);
               break;
            default:
               _loc4_.updatePart("ch",20000,[1]);
         }
         _loc4_.removePart("cc");
         var _loc5_:class_1827 = var_49.avatarManager.createAvatarImage(_loc4_.getFigureString(),"h_50",param3,this);
         if(_loc5_)
         {
            _loc5_.setDirection("full",getTeamPlayerDirection(param1));
            return _loc5_.getCroppedImage("full");
         }
         return null;
      }
      
      private function getElement(param1:class_1812, param2:String) : class_1741
      {
         return param1 != null ? param1.findChildByName(param2) : null;
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
      
      public function avatarImageReady(param1:String) : void
      {
      }
      
      public function playerRematches(param1:int) : void
      {
         var _loc3_:IItemListWindow = _window.findChildByName("player" + param1) as IItemListWindow;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc6_:Game2TeamPlayerData = _players[param1];
         if(_loc6_ == null)
         {
            return;
         }
         _loc6_.willRejoin = true;
         var _loc2_:class_1812 = _loc3_.getListItemByName("playerScoreContainer") as class_1812;
         var _loc4_:class_2251 = getElement(_loc2_,"playerScoreGlow") as class_2251;
         if(!var_793.hasKey(_loc4_))
         {
            var _loc5_:SnowWarAnimatedWindowElement = new SnowWarAnimatedWindowElement(var_49.assets,_loc4_,"rematch_",6,100,true);
            var_793.add(_loc4_,null);
         }
      }
      
      public function changeToWaitState(param1:Boolean) : void
      {
         if(!param1)
         {
            return changeToAfterSkiState();
         }
         var_61 = 2;
         stopResultsCountDown();
         var _loc5_:Array = [];
         var _loc10_:int = 0;
         var _loc9_:Dictionary = _players;
         for each(var _loc8_ in _loc9_)
         {
            var _loc6_:IItemListWindow = _window.findChildByName("team" + _loc8_.teamId + "PlayersList") as IItemListWindow;
            var _loc3_:IItemListWindow = _window.findChildByName("player" + _loc8_.userId) as IItemListWindow;
         }
         for each(var _loc7_ in _loc5_)
         {
            delete _players[_loc7_];
         }
         WindowUtils.hideElement(_window,"buttonsContainer");
         WindowUtils.hideElement(_window,"mostKillsContainer");
         WindowUtils.hideElement(_window,"mostHitsContainer");
         WindowUtils.hideElement(_window,"team1Score");
         WindowUtils.hideElement(_window,"team2Score");
         WindowUtils.setCaption(getElement(_window,"endingInformation"),"${snowwar.lobby_waiting_for_more_players}");
      }
      
      private function changeToAfterSkiState() : void
      {
         var_61 = 5;
         if(var_793)
         {
            for each(var _loc2_ in var_793)
            {
               _loc2_.dispose();
            }
            var_793.reset();
         }
         hideChatInput();
         if(var_49.freeGamesLeft == 0)
         {
            return;
         }
         _window.findChildByName("button_rematch").visible = false;
         _window.findChildByName("button_play_again").visible = true;
         var _loc1_:class_1741 = _window.findChildByName("button_play_again");
         _loc1_.enable();
         _loc1_.color = 5622784;
      }
      
      private function updateDialog() : void
      {
         if(var_1134)
         {
            return;
         }
         var _loc1_:ITextWindow = _window.findChildByName("endingInformation") as ITextWindow;
         var _loc2_:ITextWindow = _window.findChildByName("endingInformation_stroke") as ITextWindow;
         _loc1_.fontSize = 28;
         _loc2_.fontSize = 28;
         if(var_49.freeGamesLeft == 0)
         {
            WindowUtils.setCaption(getElement(_window,"button_rematch"),"${catalog.vip.buy.title}");
         }
         else if(var_61 == 0)
         {
            var_49.localization.registerParameter("snowwar.rematch","seconds",var_493.toString());
            WindowUtils.setCaption(getElement(_window,"button_rematch"),"${snowwar.rematch}");
         }
         else if(var_61 == 1)
         {
            var_49.localization.registerParameter("snowwar.please_wait","seconds",var_493.toString());
            WindowUtils.setCaption(getElement(_window,"button_rematch"),"${snowwar.please_wait}");
         }
         else if(var_61 == 3)
         {
            var_49.localization.registerParameter("snowwar.lobby_game_start_countdown","seconds",var_493.toString());
            WindowUtils.setCaption(getElement(_window,"endingInformation"),"${snowwar.lobby_game_start_countdown}");
            _loc1_.fontSize = 22;
            _loc2_.fontSize = 22;
         }
         else if(var_61 == 2)
         {
            WindowUtils.setCaption(getElement(_window,"endingInformation"),"${snowwar.lobby_waiting_for_more_players}");
            _loc1_.fontSize = 22;
            _loc2_.fontSize = 22;
         }
      }
      
      private function startCountDownTimer(param1:int) : void
      {
         disposeCountDownTimer();
         var_1457 = new Timer(1000,param1);
         var_1457.addEventListener("timer",onTick);
         var_1457.start();
         var_493 = param1;
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(var_493 && var_493 > 0)
         {
            var_493 = var_493 - 1;
            HabboGamesCom.log("On results window tick " + var_493);
            updateDialog();
         }
      }
      
      private function startResultsCountDown(param1:int) : void
      {
         startCountDownTimer(param1);
         updateDialog();
      }
      
      private function stopResultsCountDown() : void
      {
         disposeCountDownTimer();
         updateDialog();
      }
      
      public function startLobbyCountDown(param1:int) : void
      {
         var_61 = 3;
         startCountDownTimer(param1);
         updateDialog();
      }
      
      public function stopLobbyCountDown() : void
      {
         disposeCountDownTimer();
         updateDialog();
      }
      
      public function changeToLobbyState(param1:GameLobbyData) : void
      {
         var_61 = 3;
         _lobbyPlayers = new class_55();
         var _loc3_:Array = [];
         var _loc8_:int = 0;
         var _loc7_:Dictionary = _players;
         for each(var _loc6_ in _loc7_)
         {
            var _loc4_:IItemListWindow = _window.findChildByName("team" + _loc6_.teamId + "PlayersList") as IItemListWindow;
            var _loc2_:IItemListWindow = _window.findChildByName("player" + _loc6_.userId) as IItemListWindow;
         }
         for each(var _loc5_ in _loc3_)
         {
            delete _players[_loc5_];
         }
         _window.findChildByName("loadingContainer").visible = true;
         WindowUtils.hideElement(_window.findChildByName("loadingContainer") as class_1812,"loadingText");
         WindowUtils.setCaption(_window.findChildByName("arenaName"),var_49.getArenaName(param1));
         WindowUtils.colorStrokes(getElement(_window,"headerContainer"),getTeamColor(1));
         WindowUtils.setElementImage(_window.findChildByName("arenaPreview"),getBitmap("arena_" + param1.fieldType + "_preview"));
      }
      
      public function playerJoined(param1:GameLobbyPlayerData) : void
      {
         if(param1)
         {
            _lobbyPlayers.add(param1.userId,param1);
            renderLobbyPlayers();
         }
      }
      
      public function playerLeft(param1:int) : void
      {
         var _loc2_:GameLobbyPlayerData = _lobbyPlayers[param1];
         if(_loc2_ != null)
         {
            _lobbyPlayers.remove(param1);
         }
         renderLobbyPlayers();
      }
      
      private function renderLobbyPlayers() : void
      {
         clearPlayers();
         var _loc1_:Array = _lobbyPlayers.getValues();
         if(var_61 != 0 && var_61 != 1)
         {
            _loc1_.sort(GameLobbyPlayerData.var_3611);
         }
         for each(var _loc2_ in _loc1_)
         {
            addLobbyPlayer(_loc2_);
         }
      }
      
      private function clearPlayers() : void
      {
         var _loc2_:IItemListWindow = null;
         var _loc1_:int = 1;
         while(true)
         {
            _loc2_ = _window.findChildByName("team" + _loc1_++ + "PlayersList") as IItemListWindow;
            if(_loc2_ == null)
            {
               break;
            }
            _loc2_.destroyListItems();
         }
      }
      
      private function addLobbyPlayer(param1:GameLobbyPlayerData) : void
      {
         HabboGamesCom.log("Add Lobby Player: " + [param1.name,param1.userId,param1.teamId]);
         var _loc4_:int = _lobbyPlayers.getKeys().indexOf(param1.userId) % 2 + 1;
         var _loc7_:IItemListWindow = _window.findChildByName("team" + _loc4_ + "PlayersList") as IItemListWindow;
         if(_loc7_ == null)
         {
            return;
         }
         var _loc6_:IItemListWindow = WindowUtils.createWindow("snowwar_lobby_player_team_" + _loc4_) as IItemListWindow;
         if(_loc6_ == null)
         {
            return;
         }
         var _loc8_:class_1812 = _loc6_.getListItemByName("playerImageContainer") as class_1812;
         var _loc5_:class_1812 = _loc6_.getListItemByName("playerDataContainer") as class_1812;
         var _loc2_:class_1812 = _loc6_.getListItemByName("playerScoreContainer") as class_1812;
         WindowUtils.setElementImage(getElement(_loc8_,"playerImage"),getAvatarFigure(_loc4_,param1.figure,param1.gender));
         WindowUtils.setCaption(getElement(_loc5_,"playerName"),param1.name);
         WindowUtils.hideElement(_loc5_,"playerStats");
         WindowUtils.hideElement(_loc2_,"playerScore");
         WindowUtils.hideElement(_loc5_,"playerTotalStats");
         var _loc9_:class_2251 = _loc5_.findChildByName("skillLevel") as class_2251;
         if(_loc9_.bitmap)
         {
            _loc9_.bitmap.dispose();
         }
         _loc9_.bitmap = getSkillLevelImage(param1.skillLevel,_loc4_);
         var _loc3_:IRegionWindow = _loc5_.findChildByName("scoreTooltip") as IRegionWindow;
         _loc3_.toolTipCaption = param1.totalScore.toString() + "/" + param1.scoreToNextLevel.toString();
         _loc3_.visible = true;
         _loc7_.addListItem(_loc6_);
      }
      
      private function getSkillLevelImage(param1:int, param2:int) : BitmapData
      {
         var _loc6_:BitmapData = null;
         var _loc8_:int = 0;
         var _loc7_:Point = null;
         param1 = Math.min(param1,30);
         var _loc3_:BitmapData = var_49.assets.getAssetByName("star_empty").content as BitmapData;
         var _loc11_:BitmapData = var_49.assets.getAssetByName("star_filled_bronze").content as BitmapData;
         var _loc9_:BitmapData = var_49.assets.getAssetByName("star_filled_silver").content as BitmapData;
         var _loc10_:BitmapData = var_49.assets.getAssetByName("star_filled_gold").content as BitmapData;
         var _loc5_:int = param1 > 0 ? (param1 - 1) % 10 + 1 : 0;
         var _loc4_:BitmapData = new BitmapData(150,13,true,0);
         _loc8_ = 0;
         while(_loc8_ < 10)
         {
            _loc7_ = param2 == 1 ? new Point(_loc8_ * 15,0) : new Point((9 - _loc8_) * 15,0);
            _loc6_ = param1 > 20 ? (_loc5_-- > 0 ? _loc10_ : _loc3_) : (param1 > 10 ? (_loc5_-- > 0 ? _loc9_ : _loc3_) : (_loc5_-- > 0 ? _loc11_ : _loc3_));
            _loc4_.copyPixels(_loc6_,_loc6_.rect,_loc7_);
            _loc8_++;
         }
         return _loc4_;
      }
      
      public function updateGamesLeft() : void
      {
         var _loc4_:ITextWindow = null;
         var _loc1_:class_1741 = null;
         var _loc3_:class_1812 = _window.findChildByName("buttonsContainer") as class_1812;
         var _loc2_:class_1812 = _window.findChildByName("statusContainer") as class_1812;
         if(_loc2_ && _loc3_)
         {
            _loc3_.visible = true;
            WindowUtils.setCaption(_loc2_.findChildByName("games_left"),var_49.freeGamesLeft.toString());
            _loc4_ = _loc2_.findChildByName("games_left_stroke") as ITextWindow;
            _loc1_ = _window.findChildByName("button_rematch");
            updateGettingMoreGamesOption();
            if(var_49.hasUnlimitedGames)
            {
               _loc1_.enable();
               _loc1_.color = 5622784;
               _loc2_.visible = false;
               return;
            }
            switch(var_49.freeGamesLeft - -1)
            {
               case 0:
                  _loc1_.enable();
                  _loc1_.color = 5622784;
                  _loc2_.visible = false;
                  break;
               case 1:
                  _loc4_.textColor = 16711680;
                  _loc1_.enable();
                  _loc1_.color = 5622784;
                  break;
               default:
                  _loc4_.textColor = 1079212;
                  _loc1_.enable();
                  _loc1_.color = 5622784;
            }
         }
      }
      
      private function onGetMore(param1:WindowMouseEvent) : void
      {
         switch(var_5287 - 1)
         {
            case 0:
               var_49.openGetMoreGames("gameFramework.buyTokens.clicked.rematchView");
               break;
            default:
               onClose(true);
               var_49.openClubCenter("gameFramework.getVip.clicked.rematchView");
         }
      }
      
      private function hideChatInput() : void
      {
         var_49.roomUI.hideWidget("RWE_CHAT_INPUT_WIDGET");
      }
   }
}

