package com.sulake.habbo.game.snowwar
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.FullGameStatusData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2PlayerData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameObjectsData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameStatusData;
   import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameEvent;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   import com.sulake.habbo.game.snowwar.events.CreateSnowballEvent;
   import com.sulake.habbo.game.snowwar.events.HumanGetsSnowballsFromMachineEvent;
   import com.sulake.habbo.game.snowwar.events.HumanLeftGameEvent;
   import com.sulake.habbo.game.snowwar.events.HumanStartsToMakeASnowballEvent;
   import com.sulake.habbo.game.snowwar.events.HumanThrowsSnowballAtHumanEvent;
   import com.sulake.habbo.game.snowwar.events.HumanThrowsSnowballAtPositionEvent;
   import com.sulake.habbo.game.snowwar.events.MachineCreatesSnowballEvent;
   import com.sulake.habbo.game.snowwar.events.NewMoveTargetEvent;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowBallGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballGivingGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballMachineGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballPileGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.TreeGameObject;
   import com.sulake.habbo.communication.messages.incoming.game.score.Game2FriendsLeaderboardEvent;
   import com.sulake.habbo.communication.messages.incoming.game.score.Game2TotalGroupLeaderboardEvent;
   import com.sulake.habbo.communication.messages.incoming.game.score.Game2TotalLeaderboardEvent;
   import com.sulake.habbo.communication.messages.incoming.game.score.Game2WeeklyFriendsLeaderboardEvent;
   import com.sulake.habbo.communication.messages.incoming.game.score.Game2WeeklyGroupLeaderboardEvent;
   import com.sulake.habbo.communication.messages.incoming.game.score.Game2WeeklyLeaderboardEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2AccountGameStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameCancelledMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameDirectoryStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2InArenaQueueMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2JoiningGameFailedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2StartCounterMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2StartingGameFailedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2StopCounterMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2UserBlockedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2UserLeftGameMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameStartedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2UserJoinedGameMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameLongDataMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameCreatedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.ingame.Game2GameStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.ingame.Game2FullGameStatusMessageEvent;
   import package_197.CreateSnowballEventData;
   import package_197.HumanGetsSnowballsFromMachineEventData;
   import package_197.HumanLeftGameEventData;
   import package_197.HumanStartsToMakeASnowballEventData;
   import package_197.HumanThrowsSnowballAtHumanEventData;
   import package_197.HumanThrowsSnowballAtPositionEventData;
   import package_197.MachineCreatesSnowballEventData;
   import package_197.NewMoveTargetEventData;
   import package_197.SnowWarGameEventData;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2AccountGameStatusMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameDirectoryStatusMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2InArenaQueueMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2JoiningGameFailedMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2StartCounterMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2UserBlockedMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2UserLeftGameMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2UserJoinedGameMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameLongDataMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameStartedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameCreatedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.score.Game2GroupLeaderboardParser;
   import com.sulake.habbo.communication.messages.parser.game.score.Game2LeaderboardParser;
   import com.sulake.habbo.communication.messages.parser.game.score.Game2WeeklyGroupLeaderboardParser;
   import com.sulake.habbo.communication.messages.parser.game.score.Game2WeeklyLeaderboardParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.ingame.Game2FullGameStatusMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.ingame.Game2GameStatusMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
   import package_38.HumanGameObjectData;
   import package_38.SnowWarGameObjectData;
   import package_38.SnowballGameObjectData;
   import package_38.SnowballMachineGameObjectData;
   import package_38.SnowballPileGameObjectData;
   import package_38.TreeGameObjectData;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2GetAccountGameStatusMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageStartingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2GameEndingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2ArenaEnteredMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2PlayerRematchesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2EnterArenaFailedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2PlayerExitedGameArenaMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageEndingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2EnterArenaMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageStillLoadingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2GameRejoinMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageLoadMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2GameChatFromPlayerMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageRunningMessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageStartingMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2PlayerExitedGameArenaMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2GameEndingMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2GameRejoinMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageStillLoadingMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2GameChatFromPlayerMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageRunningMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageLoadMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageEndingMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2EnterArenaMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2EnterArenaFailedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2ArenaEnteredMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2PlayerRematchesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class class_1762 implements class_13
   {
      
      private var var_21:SnowWarEngine;
      
      private var var_1134:Boolean = false;
      
      public function class_1762(param1:SnowWarEngine)
      {
         super();
         var_21 = param1;
         var _loc2_:class_57 = var_21.communication;
         _loc2_.addHabboConnectionMessageEvent(new Game2WeeklyFriendsLeaderboardEvent(onWeeklyFriendsLeaderboard));
         _loc2_.addHabboConnectionMessageEvent(new Game2UserJoinedGameMessageEvent(onUserJoined));
         _loc2_.addHabboConnectionMessageEvent(new Game2StageStillLoadingMessageEvent(onStageStillLoading));
         _loc2_.addHabboConnectionMessageEvent(new Game2GameDirectoryStatusMessageEvent(onGameDirectoryStatus));
         _loc2_.addHabboConnectionMessageEvent(new Game2GameCreatedMessageEvent(onGameCreated));
         _loc2_.addHabboConnectionMessageEvent(new Game2StageLoadMessageEvent(onStageLoad));
         _loc2_.addHabboConnectionMessageEvent(new Game2StageEndingMessageEvent(onStageEnding));
         _loc2_.addHabboConnectionMessageEvent(new Game2StageStartingMessageEvent(onStageStarting));
         _loc2_.addHabboConnectionMessageEvent(new Game2PlayerExitedGameArenaMessageEvent(onPlayerExitedArena));
         _loc2_.addHabboConnectionMessageEvent(new Game2UserBlockedMessageEvent(onPlayerBlockStatusChange));
         _loc2_.addHabboConnectionMessageEvent(new Game2GameStatusMessageEvent(onGameStatus));
         _loc2_.addHabboConnectionMessageEvent(new Game2StartingGameFailedMessageEvent(onStartingGameFailed));
         _loc2_.addHabboConnectionMessageEvent(new Game2GameLongDataMessageEvent(onGameLongData));
         _loc2_.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
         _loc2_.addHabboConnectionMessageEvent(new Game2TotalGroupLeaderboardEvent(onTotalGroupLeaderboard));
         _loc2_.addHabboConnectionMessageEvent(new Game2GameChatFromPlayerMessageEvent(onGameChat));
         _loc2_.addHabboConnectionMessageEvent(new Game2StageRunningMessageEvent(onStageRunning));
         _loc2_.addHabboConnectionMessageEvent(new Game2UserLeftGameMessageEvent(onUserLeft));
         _loc2_.addHabboConnectionMessageEvent(new Game2GameCancelledMessageEvent(onGameCancelled));
         _loc2_.addHabboConnectionMessageEvent(new Game2EnterArenaMessageEvent(onEnterArena));
         _loc2_.addHabboConnectionMessageEvent(new Game2PlayerRematchesMessageEvent(onPlayerRematches));
         _loc2_.addHabboConnectionMessageEvent(new Game2GameStartedMessageEvent(onGameStarted));
         _loc2_.addHabboConnectionMessageEvent(new Game2StopCounterMessageEvent(onLobbyCounterStop));
         _loc2_.addHabboConnectionMessageEvent(new Game2WeeklyLeaderboardEvent(onWeeklyLeaderboard));
         _loc2_.addHabboConnectionMessageEvent(new Game2InArenaQueueMessageEvent(onInArenaQueue));
         _loc2_.addHabboConnectionMessageEvent(new Game2JoiningGameFailedMessageEvent(onJoiningGameFailed));
         _loc2_.addHabboConnectionMessageEvent(new Game2StartCounterMessageEvent(onLobbyCounterStart));
         _loc2_.addHabboConnectionMessageEvent(new Game2TotalLeaderboardEvent(onTotalLeaderboard));
         _loc2_.addHabboConnectionMessageEvent(new Game2FriendsLeaderboardEvent(onFriendsLeaderboard));
         _loc2_.addHabboConnectionMessageEvent(new Game2ArenaEnteredMessageEvent(onArenaEntered));
         _loc2_.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(onSubscriptionStatus));
         _loc2_.addHabboConnectionMessageEvent(new Game2AccountGameStatusMessageEvent(onAccountGameStatus));
         _loc2_.addHabboConnectionMessageEvent(new Game2EnterArenaFailedMessageEvent(onEnterArenaFailed));
         _loc2_.addHabboConnectionMessageEvent(new Game2WeeklyGroupLeaderboardEvent(onWeeklyGroupLeaderboard));
         _loc2_.addHabboConnectionMessageEvent(new Game2GameRejoinMessageEvent(onRejoinGame));
         _loc2_.addHabboConnectionMessageEvent(new Game2FullGameStatusMessageEvent(onFullGameStatus));
         _loc2_.addHabboConnectionMessageEvent(new Game2GameEndingMessageEvent(onGameEnding));
      }
      
      public function dispose() : void
      {
         var_21 = null;
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      private function onEnterArena(param1:Game2EnterArenaMessageEvent) : void
      {
         var _loc3_:Game2EnterArenaMessageEventParser = param1.getParser();
         var_21.initArena(_loc3_.gameType,_loc3_.fieldType,_loc3_.numberOfTeams,_loc3_.players);
         var _loc2_:SynchronizedGameArena = var_21.gameArena;
         var _loc4_:class_2693 = _loc2_.getCurrentStage();
         _loc4_.initialize(var_21.gameArena,_loc3_.gameLevel);
         var_21.mainView.close(false);
      }
      
      private function onEnterArenaFailed(param1:Game2EnterArenaFailedMessageEvent) : void
      {
         var _loc2_:Game2EnterArenaFailedMessageEventParser = param1.getParser();
         var _loc3_:String = "snowwar.error.generic";
         switch(_loc2_.reason - 1)
         {
            case 0:
               _loc3_ = "snowwar.error.game_already_started";
         }
         var_21.alert("${" + _loc3_ + "}");
      }
      
      private function onArenaEntered(param1:Game2ArenaEnteredMessageEvent) : void
      {
         var _loc2_:Game2ArenaEnteredMessageEventParser = param1.getParser();
         var _loc3_:Game2PlayerData = _loc2_.player;
      }
      
      private function onStageLoad(param1:Game2StageLoadMessageEvent) : void
      {
         var _loc2_:Game2StageLoadMessageEventParser = param1.getParser();
         var_21.initView();
      }
      
      private function onStageStillLoading(param1:Game2StageStillLoadingMessageEvent) : void
      {
         var _loc2_:Game2StageStillLoadingMessageEventParser = param1.getParser();
         var_21.stageLoading(_loc2_.percentage,_loc2_.finishedPlayers);
      }
      
      private function onStageStarting(param1:Game2StageStartingMessageEvent) : void
      {
         var _loc3_:Game2StageStartingMessageEventParser = param1.getParser();
         HabboGamesCom.log("[HabbosnowWarEngine] On stage start: " + _loc3_.countDown);
         var _loc2_:GameObjectsData = _loc3_.gameObjects;
         initializeGameObjects(_loc2_);
         var_21.startStage(_loc3_.countDown);
      }
      
      private function onStageRunning(param1:Game2StageRunningMessageEvent) : void
      {
         var _loc2_:Game2StageRunningMessageEventParser = param1.getParser();
         HabboGamesCom.log("[HabbosnowWarEngine] On stage running: " + _loc2_.timeToStageEnd);
         var_21.stageRunning(_loc2_.timeToStageEnd);
      }
      
      private function onStageEnding(param1:Game2StageEndingMessageEvent) : void
      {
         var _loc2_:Game2StageEndingMessageEventParser = param1.getParser();
         HabboGamesCom.log("[HabbosnowWarEngine] On stage ending: " + _loc2_.timeToNextState);
         if(_loc2_.timeToNextState == 0)
         {
            var_21.resetGameSession();
         }
      }
      
      private function onGameEnding(param1:Game2GameEndingMessageEvent) : void
      {
         var _loc2_:Game2GameEndingMessageEventParser = param1.getParser();
         HabboGamesCom.log("[HabbosnowWarEngine] On game ending: " + _loc2_.timeToNextState);
         var_21.gameOver(_loc2_.timeToNextState,_loc2_.teams,_loc2_.generalStats,_loc2_.gameResult);
      }
      
      private function onPlayerExitedArena(param1:Game2PlayerExitedGameArenaMessageEvent) : void
      {
         var _loc2_:Game2PlayerExitedGameArenaMessageEventParser = param1.getParser();
         HabboGamesCom.log("[HabbosnowWarEngine] On player exited arena. userId:" + _loc2_.userId + " gameObjectId:" + _loc2_.playerGameObjectId);
      }
      
      private function onRejoinGame(param1:Game2GameRejoinMessageEvent) : void
      {
         var _loc2_:Game2GameRejoinMessageEventParser = param1.getParser();
         HabboGamesCom.log("Rejoin game! Room Before game: " + _loc2_.roomBeforeGame);
         var_21.rejoinGame(_loc2_.roomBeforeGame);
      }
      
      private function onPlayerRematches(param1:Game2PlayerRematchesMessageEvent) : void
      {
         var _loc2_:Game2PlayerRematchesMessageEventParser = param1.getParser();
         HabboGamesCom.log("User " + _loc2_.userId + " rematches");
         var_21.playerRematches(_loc2_.userId);
      }
      
      private function onGameDirectoryStatus(param1:Game2GameDirectoryStatusMessageEvent) : void
      {
         var _loc2_:Game2GameDirectoryStatusMessageParser = param1.getParser();
         if(_loc2_.status == 0)
         {
            var_21.mainView.changeBlockStatus(_loc2_.blockLength);
            var_21.gamesPlayed = _loc2_.gamesPlayed;
            var_21.onGameDirectoryAvailable(true);
            var_21.gamesLeft(0,_loc2_.freeGamesLeft == -1,_loc2_.freeGamesLeft);
         }
         else
         {
            var_21.onGameDirectoryAvailable(false);
            HabboGamesCom.log("Game directory not available, status:" + _loc2_.status);
         }
      }
      
      private function onAccountGameStatus(param1:Game2AccountGameStatusMessageEvent) : void
      {
         var _loc2_:Game2AccountGameStatusMessageParser = param1.getParser();
         HabboGamesCom.log("FREE GAMES LEFT: " + _loc2_.freeGamesLeft + " OR HAS UNLIMITED GAMES: " + _loc2_.hasUnlimitedGames);
         var_21.gamesLeft(_loc2_.gameTypeId,_loc2_.hasUnlimitedGames,_loc2_.freeGamesLeft);
      }
      
      private function onGameCreated(param1:Game2GameCreatedMessageEvent) : void
      {
         var _loc2_:Game2GameCreatedMessageEventParser = param1.getParser();
         var _loc3_:GameLobbyData = _loc2_.gameLobbyData;
         var_21.createLobby(_loc3_);
      }
      
      private function onGameStarted(param1:Game2GameStartedMessageEvent) : void
      {
         var _loc2_:Game2GameStartedMessageEventParser = param1.getParser();
         HabboGamesCom.log("Game started!");
         var_21.gameStarted(_loc2_.lobbyData);
      }
      
      private function onLobbyCounterStart(param1:Game2StartCounterMessageEvent) : void
      {
         var _loc2_:Game2StartCounterMessageParser = param1.getParser();
         HabboGamesCom.log("Start Lobby Counter: " + _loc2_.countDownLength);
         var_21.startLobbyCounter(_loc2_.countDownLength);
      }
      
      private function onLobbyCounterStop(param1:Game2StopCounterMessageEvent) : void
      {
         var_21.stopLobbyCounter();
      }
      
      private function onGameCancelled(param1:Game2GameCancelledMessageEvent) : void
      {
         var_21.gameCancelled(false);
      }
      
      private function onInArenaQueue(param1:Game2InArenaQueueMessageEvent) : void
      {
         var _loc2_:Game2InArenaQueueMessageParser = param1.getParser();
         if(var_21.lobbyView)
         {
            var_21.lobbyView.queuePosition = _loc2_.position;
         }
      }
      
      private function onUserJoined(param1:Game2UserJoinedGameMessageEvent) : void
      {
         var _loc2_:Game2UserJoinedGameMessageEventParser = param1.getParser();
         var_21.userJoined(_loc2_.user);
      }
      
      private function onUserLeft(param1:Game2UserLeftGameMessageEvent) : void
      {
         var _loc2_:Game2UserLeftGameMessageParser = param1.getParser();
         var_21.userLeft(_loc2_.userId);
      }
      
      private function onGameLongData(param1:Game2GameLongDataMessageEvent) : void
      {
         var _loc2_:Game2GameLongDataMessageEventParser = param1.getParser();
         var _loc3_:GameLobbyData = _loc2_.gameLobbyData;
         HabboGamesCom.log("Long data received: " + [_loc3_.fieldType,_loc3_.numberOfTeams,_loc3_.maximumPlayers]);
         var_21.createLobby(_loc3_);
      }
      
      private function onJoiningGameFailed(param1:Game2JoiningGameFailedMessageEvent) : void
      {
         var _loc2_:Game2JoiningGameFailedMessageParser = param1.getParser();
         var _loc3_:String = "snowwar.error.generic";
         switch(_loc2_.reason - 2)
         {
            case 0:
               _loc3_ = "snowwar.error.duplicate_machineid";
               break;
            case 4:
            case 5:
               _loc3_ = "snowwar.error.has_active_instance";
               break;
            case 6:
               _loc3_ = "snowwar.error.no_free_games_left";
         }
         var_21.alert("${" + _loc3_ + "}");
      }
      
      private function onStartingGameFailed(param1:Game2StartingGameFailedMessageEvent) : void
      {
         var_21.alert("${snowwar.error.generic}");
      }
      
      private function onPlayerBlockStatusChange(param1:Game2UserBlockedMessageEvent) : void
      {
         var _loc2_:Game2UserBlockedMessageParser = param1.getParser();
         var_21.mainView.changeBlockStatus(_loc2_.playerBlockLength);
      }
      
      private function onFullGameStatus(param1:Game2FullGameStatusMessageEvent) : void
      {
         var _loc4_:GameStatusData = null;
         var _loc3_:Game2FullGameStatusMessageEventParser = param1.getParser();
         var _loc2_:SynchronizedGameArena = var_21.gameArena;
         HabboGamesCom.log("On full game status: ");
         var _loc5_:FullGameStatusData = _loc3_.fullStatus;
         (_loc2_.getCurrentStage() as class_2694).resetTiles();
         initializeGameObjects(_loc5_.gameObjects);
         if(_loc2_)
         {
            _loc4_ = _loc5_.gameStatus;
            _loc2_.seekToTurn(_loc4_.turn,_loc4_.checksum);
            handleGameStatus(_loc4_,true);
         }
      }
      
      private function onGameStatus(param1:Game2GameStatusMessageEvent) : void
      {
         var _loc2_:Game2GameStatusMessageEventParser = param1.getParser();
         HabboGamesCom.log("[HabbosnowWarEngine] On game status: ");
         handleGameStatus(_loc2_.status);
      }
      
      private function initializeGameObjects(param1:GameObjectsData) : void
      {
         var _loc4_:HumanGameObjectData = null;
         var _loc8_:* = false;
         var _loc16_:HumanGameObject = null;
         var _loc12_:HumanGameObject = null;
         var _loc3_:SnowballGameObjectData = null;
         var _loc11_:SnowBallGameObject = null;
         var _loc13_:HumanGameObject = null;
         var _loc7_:SnowballMachineGameObjectData = null;
         var _loc15_:SnowballMachineGameObject = null;
         var _loc9_:SnowballPileGameObjectData = null;
         var _loc5_:SnowballPileGameObject = null;
         var _loc17_:TreeGameObjectData = null;
         var _loc6_:TreeGameObject = null;
         var _loc10_:SynchronizedGameArena = var_21.gameArena;
         if(!_loc10_)
         {
            return;
         }
         var _loc14_:class_2694 = _loc10_.getCurrentStage() as class_2694;
         _loc14_.removeAllGameObjects();
         for each(var _loc2_ in param1.gameObjects)
         {
            switch(_loc2_.type - 1)
            {
               case 0:
                  _loc3_ = _loc2_ as SnowballGameObjectData;
                  _loc11_ = new SnowBallGameObject(_loc3_.id);
                  _loc13_ = _loc14_.getGameObject(_loc3_.throwingHuman) as HumanGameObject;
                  _loc11_.initializeFromData(_loc3_,_loc13_);
                  _loc14_.addGameObject(_loc11_.gameObjectId,_loc11_);
                  HabboGamesCom.log("snowball x:" + _loc3_.locationX3D + " y:" + _loc3_.locationY3D);
                  break;
               case 1:
                  _loc17_ = _loc2_ as TreeGameObjectData;
                  _loc6_ = new TreeGameObject(_loc17_,_loc14_);
                  _loc14_.addGameObject(_loc6_.gameObjectId,_loc6_);
                  HabboGamesCom.log("tree id:" + _loc6_.gameObjectId);
                  break;
               case 2:
                  _loc9_ = _loc2_ as SnowballPileGameObjectData;
                  _loc5_ = new SnowballPileGameObject(_loc9_,_loc14_);
                  _loc14_.addGameObject(_loc9_.id,_loc5_);
                  HabboGamesCom.log("pile id:" + _loc9_.id);
                  break;
               case 3:
                  _loc7_ = _loc2_ as SnowballMachineGameObjectData;
                  _loc15_ = new SnowballMachineGameObject(_loc7_,_loc14_);
                  _loc14_.addGameObject(_loc7_.id,_loc15_);
                  HabboGamesCom.log("machine id:" + _loc7_.id);
                  break;
               case 4:
                  _loc4_ = _loc2_ as HumanGameObjectData;
                  _loc8_ = _loc4_.name == var_21.sessionDataManager.userName;
                  if(_loc8_)
                  {
                     var_21.ownId = _loc4_.id;
                  }
                  _loc16_ = new HumanGameObject(_loc14_,_loc4_,false,var_21);
                  _loc14_.addGameObject(_loc16_.gameObjectId,_loc16_);
                  _loc16_.visualizationMode = 0;
                  if(_loc8_ && var_21.isGhostEnabled)
                  {
                     if(var_21.isGhostVisualizationEnabled)
                     {
                        _loc16_.visualizationMode = 1;
                     }
                     else
                     {
                        _loc16_.visualizationMode = 2;
                     }
                     if(var_21.gameArena.getCurrentStage().getGameObject(_loc16_.ghostObjectId) == null)
                     {
                        _loc12_ = new HumanGameObject(_loc14_,_loc4_,true,var_21);
                        _loc12_.gameObjectId = _loc16_.ghostObjectId;
                        _loc14_.addGameObject(_loc12_.gameObjectId,_loc12_);
                     }
                  }
                  HabboGamesCom.log("human id:" + _loc4_.id + " x:" + _loc4_.currentLocationX + " y:" + _loc4_.currentLocationY);
                  break;
               default:
                  HabboGamesCom.log("Unkonwn game-object:" + _loc2_.type);
            }
         }
      }
      
      private function handleGameStatus(param1:GameStatusData, param2:Boolean = false) : void
      {
         var _loc11_:Array = null;
         var _loc3_:class_55 = param1.events as class_55;
         var _loc4_:SynchronizedGameArena = var_21.gameArena;
         if(!_loc4_)
         {
            return;
         }
         var _loc10_:int = param1.turn;
         for each(var _loc5_ in _loc3_.getKeys())
         {
            _loc11_ = _loc3_.getValue(_loc5_) as Array;
            for each(var _loc9_ in _loc11_)
            {
               switch(_loc9_.id - 1)
               {
                  case 0:
                     var _loc7_:ISynchronizedGameEvent = handleHumanLeftGameEvent(_loc9_ as HumanLeftGameEventData);
                     break;
                  case 1:
                     _loc7_ = handleNewMoveTargetEvent(_loc9_ as NewMoveTargetEventData);
                     break;
                  case 2:
                     _loc7_ = handleThrowSnowballAtHuman(_loc9_ as HumanThrowsSnowballAtHumanEventData);
                     var _loc6_:ISynchronizedGameEvent = handleGhostThrowSnowballAtHuman(_loc9_ as HumanThrowsSnowballAtHumanEventData);
                     break;
                  case 3:
                     _loc7_ = handleThrowSnowballAtPosition(_loc9_ as HumanThrowsSnowballAtPositionEventData);
                     _loc6_ = handleGhostThrowSnowballAtPosition(_loc9_ as HumanThrowsSnowballAtPositionEventData);
                     break;
                  case 6:
                     _loc7_ = handleHumanStartsToMakeASnowball(_loc9_ as HumanStartsToMakeASnowballEventData);
                     _loc6_ = handleGhostStartsToMakeASnowball(_loc9_ as HumanStartsToMakeASnowballEventData);
                     break;
                  case 7:
                     _loc7_ = handleCreateSnowballEvent(_loc9_ as CreateSnowballEventData);
                     break;
                  case 10:
                     _loc7_ = handleMachineCreatesSnowballEvent(_loc9_ as MachineCreatesSnowballEventData);
                     break;
                  case 11:
                     _loc7_ = handleHumanGetsSnowballFromMachineEvent(_loc9_ as HumanGetsSnowballsFromMachineEventData);
                     break;
                  default:
                     HabboGamesCom.log("Unknown event id " + _loc9_.id);
               }
            }
         }
         var _loc8_:int = param1.checksum;
         var_21.nextTurn(_loc10_,_loc8_,param2);
      }
      
      private function handleHumanGetsSnowballFromMachineEvent(param1:HumanGetsSnowballsFromMachineEventData) : HumanGetsSnowballsFromMachineEvent
      {
         var _loc2_:SynchronizedGameArena = var_21.gameArena;
         var _loc3_:class_2693 = _loc2_.getCurrentStage();
         var _loc4_:HumanGameObject = _loc3_.getGameObject(param1.humanGameObjectId) as HumanGameObject;
         var _loc5_:SnowballGivingGameObject = _loc3_.getGameObject(param1.snowBallMachineReference) as SnowballGivingGameObject;
         return new HumanGetsSnowballsFromMachineEvent(_loc4_,_loc5_);
      }
      
      private function handleMachineCreatesSnowballEvent(param1:MachineCreatesSnowballEventData) : MachineCreatesSnowballEvent
      {
         var _loc2_:SynchronizedGameArena = var_21.gameArena;
         var _loc3_:class_2693 = _loc2_.getCurrentStage();
         var _loc4_:SnowballMachineGameObject = _loc3_.getGameObject(param1.snowBallMachineReference) as SnowballMachineGameObject;
         return new MachineCreatesSnowballEvent(_loc4_);
      }
      
      private function handleThrowSnowballAtPosition(param1:HumanThrowsSnowballAtPositionEventData) : HumanThrowsSnowballAtPositionEvent
      {
         var _loc2_:SynchronizedGameArena = var_21.gameArena;
         var _loc3_:class_2693 = _loc2_.getCurrentStage();
         var _loc4_:HumanGameObject = _loc3_.getGameObject(param1.humanGameObjectId) as HumanGameObject;
         return new HumanThrowsSnowballAtPositionEvent(_loc4_,param1.targetX,param1.targetY,param1.trajectory);
      }
      
      private function handleThrowSnowballAtHuman(param1:HumanThrowsSnowballAtHumanEventData) : HumanThrowsSnowballAtHumanEvent
      {
         var _loc3_:SynchronizedGameArena = var_21.gameArena;
         var _loc4_:class_2693 = _loc3_.getCurrentStage();
         var _loc5_:HumanGameObject = _loc4_.getGameObject(param1.humanGameObjectId) as HumanGameObject;
         var _loc2_:HumanGameObject = _loc4_.getGameObject(param1.targetHumanGameObjectId) as HumanGameObject;
         return new HumanThrowsSnowballAtHumanEvent(_loc5_,_loc2_,param1.trajectory);
      }
      
      private function handleHumanStartsToMakeASnowball(param1:HumanStartsToMakeASnowballEventData) : HumanStartsToMakeASnowballEvent
      {
         var _loc2_:SynchronizedGameArena = var_21.gameArena;
         var _loc3_:class_2693 = _loc2_.getCurrentStage();
         var _loc4_:HumanGameObject = _loc3_.getGameObject(param1.humanGameObjectId) as HumanGameObject;
         return new HumanStartsToMakeASnowballEvent(_loc4_);
      }
      
      private function handleCreateSnowballEvent(param1:CreateSnowballEventData) : CreateSnowballEvent
      {
         var _loc2_:SynchronizedGameArena = var_21.gameArena;
         var _loc3_:class_2693 = _loc2_.getCurrentStage();
         var _loc4_:HumanGameObject = _loc3_.getGameObject(param1.humanGameObjectId) as HumanGameObject;
         return new CreateSnowballEvent(param1.snowBallGameObjectId,_loc4_,param1.targetX,param1.targetY,param1.trajectory);
      }
      
      private function handleNewMoveTargetEvent(param1:NewMoveTargetEventData) : NewMoveTargetEvent
      {
         var _loc2_:SynchronizedGameArena = var_21.gameArena;
         var _loc3_:class_2693 = _loc2_.getCurrentStage();
         var _loc4_:HumanGameObject = _loc3_.getGameObject(param1.humanGameObjectId) as HumanGameObject;
         return new NewMoveTargetEvent(_loc4_,param1.x,param1.y);
      }
      
      private function handleHumanLeftGameEvent(param1:HumanLeftGameEventData) : HumanLeftGameEvent
      {
         var _loc2_:SynchronizedGameArena = var_21.gameArena;
         var _loc3_:class_2693 = _loc2_.getCurrentStage();
         var _loc4_:HumanGameObject = _loc3_.getGameObject(param1.humanGameObjectId) as HumanGameObject;
         return new HumanLeftGameEvent(_loc4_);
      }
      
      private function handleGhostThrowSnowballAtPosition(param1:HumanThrowsSnowballAtPositionEventData) : HumanThrowsSnowballAtPositionEvent
      {
         var _loc2_:SynchronizedGameArena = null;
         var _loc3_:class_2693 = null;
         if(var_21.isGhostEnabled)
         {
            _loc2_ = var_21.gameArena;
            _loc3_ = _loc2_.getCurrentStage();
            if(param1.humanGameObjectId == var_21.ownId)
            {
               return new HumanThrowsSnowballAtPositionEvent(var_21.getGhostPlayer(),param1.targetX,param1.targetY,param1.trajectory);
            }
         }
         return null;
      }
      
      private function handleGhostThrowSnowballAtHuman(param1:HumanThrowsSnowballAtHumanEventData) : HumanThrowsSnowballAtHumanEvent
      {
         var _loc3_:SynchronizedGameArena = null;
         var _loc4_:class_2693 = null;
         var _loc2_:HumanGameObject = null;
         if(var_21.isGhostEnabled)
         {
            _loc3_ = var_21.gameArena;
            _loc4_ = _loc3_.getCurrentStage();
            _loc2_ = _loc4_.getGameObject(param1.targetHumanGameObjectId) as HumanGameObject;
            if(param1.humanGameObjectId == var_21.ownId)
            {
               return new HumanThrowsSnowballAtHumanEvent(var_21.getGhostPlayer(),_loc2_,param1.trajectory);
            }
         }
         return null;
      }
      
      private function handleGhostStartsToMakeASnowball(param1:HumanStartsToMakeASnowballEventData) : HumanStartsToMakeASnowballEvent
      {
         var _loc2_:SynchronizedGameArena = null;
         var _loc3_:class_2693 = null;
         var _loc4_:HumanGameObject = null;
         if(var_21.isGhostEnabled)
         {
            _loc2_ = var_21.gameArena;
            _loc3_ = _loc2_.getCurrentStage();
            _loc4_ = _loc3_.getGameObject(param1.humanGameObjectId) as HumanGameObject;
            if(param1.humanGameObjectId == var_21.ownId)
            {
               return new HumanStartsToMakeASnowballEvent(var_21.getGhostPlayer());
            }
         }
         return null;
      }
      
      private function onGameChat(param1:Game2GameChatFromPlayerMessageEvent) : void
      {
         var _loc2_:Game2GameChatFromPlayerMessageEventParser = param1.getParser();
         if(var_21 != null)
         {
            var_21.addChatMessage(_loc2_.userId,_loc2_.chatMessage);
         }
      }
      
      private function onSubscriptionStatus(param1:ScrSendUserInfoEvent) : void
      {
         if(var_21 != null)
         {
            var_21.send(new Game2GetAccountGameStatusMessageComposer(0));
            if(var_21.mainView.gameLobbyWindowActive)
            {
               return;
            }
            if(!var_21.gameCenterEnabled)
            {
               var_21.mainView.openMainWindow(false);
            }
         }
      }
      
      private function onRoomEnter(param1:RoomEntryInfoMessageEvent) : void
      {
         var_21.promoteGame();
      }
      
      private function onFriendsLeaderboard(param1:Game2FriendsLeaderboardEvent) : void
      {
         var _loc2_:Game2LeaderboardParser = param1.getParser();
         if(var_21.leaderboard)
         {
            var_21.leaderboard.addFriendAllTimeData(_loc2_.leaderboard,_loc2_.totalListSize);
         }
      }
      
      private function onTotalLeaderboard(param1:Game2TotalLeaderboardEvent) : void
      {
         var _loc2_:Game2LeaderboardParser = param1.getParser();
         if(var_21.leaderboard)
         {
            var_21.leaderboard.addAllTimeData(_loc2_.leaderboard,_loc2_.totalListSize);
         }
      }
      
      private function onTotalGroupLeaderboard(param1:Game2TotalGroupLeaderboardEvent) : void
      {
         var _loc2_:Game2GroupLeaderboardParser = param1.getParser();
         if(var_21.leaderboard)
         {
            var_21.leaderboard.addAllTimeGroupData(_loc2_.leaderboard,_loc2_.totalListSize,_loc2_.favouriteGroupId);
         }
      }
      
      private function onWeeklyGroupLeaderboard(param1:Game2WeeklyGroupLeaderboardEvent) : void
      {
         var _loc2_:Game2WeeklyGroupLeaderboardParser = param1.getParser();
         if(var_21.leaderboard)
         {
            var_21.leaderboard.addWeeklyGroupData(_loc2_.year,_loc2_.week,_loc2_.leaderboard,_loc2_.totalListSize,_loc2_.maxOffset,_loc2_.minutesUntilReset,_loc2_.favouriteGroupId);
         }
      }
      
      private function onWeeklyLeaderboard(param1:Game2WeeklyLeaderboardEvent) : void
      {
         var _loc2_:Game2WeeklyLeaderboardParser = param1.getParser();
         if(var_21.leaderboard)
         {
            var_21.leaderboard.addWeeklyData(_loc2_.year,_loc2_.week,_loc2_.leaderboard,_loc2_.totalListSize,_loc2_.maxOffset,_loc2_.minutesUntilReset);
         }
      }
      
      private function onWeeklyFriendsLeaderboard(param1:Game2WeeklyFriendsLeaderboardEvent) : void
      {
         var _loc2_:Game2WeeklyLeaderboardParser = param1.getParser();
         if(var_21.leaderboard)
         {
            var_21.leaderboard.addFriendWeeklyData(_loc2_.year,_loc2_.week,_loc2_.leaderboard,_loc2_.totalListSize,_loc2_.maxOffset,_loc2_.minutesUntilReset);
         }
      }
   }
}

