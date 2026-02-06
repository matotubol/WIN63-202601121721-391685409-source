package com.sulake.habbo.sound.music
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.sound.*;
   import com.sulake.habbo.sound.events.NowPlayingEvent;
   import com.sulake.habbo.sound.events.SongDiskInventoryReceivedEvent;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import com.sulake.habbo.sound.events.SoundCompleteEvent;
   import com.sulake.habbo.sound.trax.TraxSequencer;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.parser.sound.TraxSongInfoMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.sound.UserSongDisksInventoryMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.sound.TraxSongInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.sound.UserSongDisksInventoryMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.sound.class_3637;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetNowPlayingMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetSongInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetUserSongDisksMessageComposer;
   
   public class HabboMusicController implements class_1912, class_13
   {
      
      public static const SKIP_POSITION_SET:int = -1;
      
      private static const MAXIMUM_NOTIFY_PRIORITY:int = 0;
      
      private var _soundManager:HabboSoundManagerFlash10;
      
      private var var_37:IConnection;
      
      private var name_1:IEventDispatcher;
      
      private var _roomEvents:IEventDispatcher;
      
      private var var_539:class_55 = new class_55();
      
      private var var_1097:class_55 = new class_55();
      
      private var var_1216:Array = [];
      
      private var var_692:class_3073 = null;
      
      private var _disposed:Boolean = false;
      
      private var var_725:Array = [];
      
      private var var_1597:Array = [];
      
      private var var_402:int = -1;
      
      private var var_2409:int = -1;
      
      private var var_3123:int = -1;
      
      private var var_2006:Timer;
      
      private var var_711:class_55 = new class_55();
      
      private var var_1782:Array = [];
      
      private var _messageEvents:Array = [];
      
      private var var_3826:int = -1;
      
      private var _previousNotificationTime:int = -1;
      
      public function HabboMusicController(param1:HabboSoundManagerFlash10, param2:IEventDispatcher, param3:IEventDispatcher, param4:IConnection)
      {
         super();
         _soundManager = param1;
         name_1 = param2;
         _roomEvents = param3;
         var_37 = param4;
         _messageEvents.push(new TraxSongInfoMessageEvent(onSongInfoMessage));
         _messageEvents.push(new UserSongDisksInventoryMessageEvent(onSongDiskInventoryMessage));
         for each(var _loc6_ in _messageEvents)
         {
            var_37.addMessageEvent(_loc6_);
         }
         _roomEvents.addEventListener("ROSM_JUKEBOX_INIT",onJukeboxInit);
         _roomEvents.addEventListener("ROSM_JUKEBOX_DISPOSE",onJukeboxDispose);
         _roomEvents.addEventListener("ROSM_SOUND_MACHINE_INIT",onSoundMachineInit);
         _roomEvents.addEventListener("ROSM_SOUND_MACHINE_DISPOSE",onSoundMachineDispose);
         var_2006 = new Timer(1000);
         var_2006.start();
         var_2006.addEventListener("timer",sendNextSongRequestMessage);
         name_1.addEventListener("SCE_TRAX_SONG_COMPLETE",onSongFinishedPlayingEvent);
         var _loc5_:int = 0;
         while(true)
         {
            var_725[0] = null;
            var_1597[0] = 0;
            _loc5_++;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get events() : IEventDispatcher
      {
         return name_1;
      }
      
      protected function onSongFinishedPlayingEvent(param1:SoundCompleteEvent) : void
      {
         var _loc2_:int = 0;
         class_21.log("Song " + param1.id + " finished playing");
         if(getSongIdPlayingAtPriority(var_402) == param1.id)
         {
            if(getTopRequestPriority() == var_402 && getSongRequestCountAtPriority(var_402) == var_3123)
            {
               resetSongStartRequest(var_402);
            }
            _loc2_ = var_402;
            playSongWithHighestPriority();
            if(_loc2_ >= 2)
            {
               name_1.dispatchEvent(new NowPlayingEvent("NPW_USER_STOP_SONG",_loc2_,param1.id,-1));
            }
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _soundManager = null;
            var_1216 = null;
            if(var_37)
            {
               for each(var _loc4_ in _messageEvents)
               {
                  var_37.removeMessageEvent(_loc4_);
                  _loc4_.dispose();
               }
               _messageEvents = null;
               var_37 = null;
            }
            if(var_692)
            {
               var_692.dispose();
               var_692 = null;
            }
            if(var_539)
            {
               var _loc3_:int = 0;
               while(0 < var_539.length)
               {
                  var _loc1_:SongDataEntry = var_539.getWithIndex(0) as SongDataEntry;
                  var _loc2_:class_1814 = null.soundObject as class_1814;
                  null.soundObject = null;
                  _loc3_++;
               }
               var_539.dispose();
               var_539 = null;
            }
            if(var_1097 != null)
            {
               var_1097.dispose();
               var_1097 = null;
            }
            var_2006.stop();
            var_2006 = null;
            if(_roomEvents)
            {
               _roomEvents.removeEventListener("ROSM_JUKEBOX_INIT",onJukeboxInit);
               _roomEvents.removeEventListener("ROSM_JUKEBOX_DISPOSE",onJukeboxDispose);
               _roomEvents.removeEventListener("ROSM_SOUND_MACHINE_INIT",onSoundMachineInit);
               _roomEvents.removeEventListener("ROSM_SOUND_MACHINE_DISPOSE",onSoundMachineDispose);
            }
            if(var_711 != null)
            {
               var_711.dispose();
               var_711 = null;
            }
            _disposed = true;
         }
      }
      
      public function getRoomItemPlaylist(param1:int = -1) : class_3073
      {
         return var_692;
      }
      
      private function addSongStartRequest(param1:int, param2:int, param3:Number, param4:Number, param5:Number, param6:Number) : Boolean
      {
         if(param1 < 0 || param1 >= 4)
         {
            return false;
         }
         var _loc7_:SongStartRequestData = new SongStartRequestData(param2,param3,param4,param5,param6);
         var_725[param1] = _loc7_;
         var_1597[param1] += 1;
         return true;
      }
      
      private function getSongStartRequest(param1:int) : SongStartRequestData
      {
         return var_725[param1];
      }
      
      private function getSongIdRequestedAtPriority(param1:int) : int
      {
         if(param1 < 0 || param1 >= 4)
         {
            return -1;
         }
         if(var_725[param1] == null)
         {
            return -1;
         }
         var _loc2_:SongStartRequestData = var_725[param1];
         return _loc2_.songId;
      }
      
      private function getSongRequestCountAtPriority(param1:int) : int
      {
         if(param1 < 0 || param1 >= 4)
         {
            return -1;
         }
         return var_1597[param1];
      }
      
      private function getTopRequestPriority() : int
      {
         var _loc1_:int = 0;
         _loc1_ = var_725.length - 1;
         while(_loc1_ >= 0)
         {
            if(var_725[_loc1_] != null)
            {
               return _loc1_;
            }
            _loc1_--;
         }
         return -1;
      }
      
      private function resetSongStartRequest(param1:int) : void
      {
         if(param1 >= 0 && param1 < 4)
         {
            var_725[param1] = null;
         }
      }
      
      private function reRequestSongAtPriority(param1:int) : void
      {
         var _loc2_:int = param1;
         var _loc3_:* = var_1597[_loc2_] + 1;
         var_1597[_loc2_] = _loc3_;
      }
      
      private function processSongEntryForPlaying(param1:int, param2:Boolean = true) : Boolean
      {
         var _loc4_:SongDataEntry = getSongDataEntry(param1);
         if(_loc4_ == null)
         {
            addSongInfoRequest(param1);
            return false;
         }
         if(_loc4_.soundObject == null)
         {
            _loc4_.soundObject = _soundManager.loadTraxSong(_loc4_.id,_loc4_.songData);
         }
         var _loc3_:class_1814 = _loc4_.soundObject;
         if(!_loc3_.ready)
         {
            return false;
         }
         return true;
      }
      
      public function playSong(param1:int, param2:int, param3:Number = 0, param4:Number = 0, param5:Number = 0.5, param6:Number = 0.5) : Boolean
      {
         class_21.log("Requesting " + param1 + " for playing");
         if(!addSongStartRequest(param2,param1,param3,param4,param5,param6))
         {
            return false;
         }
         if(!processSongEntryForPlaying(param1))
         {
            return false;
         }
         if(param2 >= var_402)
         {
            playSongObject(param2,param1);
         }
         else
         {
            class_21.log("Higher priority song blocked playing. Stored song " + param1 + " for priority " + param2);
         }
         return true;
      }
      
      private function playSongWithHighestPriority() : void
      {
         var_402 = -1;
         var_2409 = -1;
         var_3123 = -1;
         var _loc1_:int = getTopRequestPriority();
         var _loc2_:int = _loc1_;
         while(true)
         {
            var _loc3_:int = getSongIdRequestedAtPriority(0);
            if(playSongObject(0,0))
            {
               break;
            }
            _loc2_--;
         }
      }
      
      public function stop(param1:int) : void
      {
         var _loc2_:* = param1 == var_402;
         var _loc3_:* = getTopRequestPriority() == param1;
         if(_loc2_)
         {
            resetSongStartRequest(param1);
            stopSongAtPriority(param1);
         }
         else
         {
            resetSongStartRequest(param1);
            if(_loc3_)
            {
               reRequestSongAtPriority(var_402);
            }
         }
      }
      
      private function stopSongAtPriority(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:SongDataEntry = null;
         if(param1 == var_402 && var_402 >= 0)
         {
            _loc3_ = getSongIdPlayingAtPriority(param1);
            if(_loc3_ >= 0)
            {
               _loc2_ = getSongDataEntry(_loc3_);
               stopSongDataEntry(_loc2_);
               return true;
            }
         }
         return false;
      }
      
      private function stopSongDataEntry(param1:SongDataEntry) : void
      {
         if(param1 != null)
         {
            class_21.log("Stopping current song " + param1.id);
            var _loc2_:class_1814 = param1.soundObject;
         }
      }
      
      private function getSongDataEntry(param1:int) : SongDataEntry
      {
         if(var_539 != null)
         {
            var _loc2_:SongDataEntry = var_539.getValue(param1) as SongDataEntry;
         }
         return null;
      }
      
      public function updateVolume(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc4_ = getSongIdPlayingAtPriority(_loc3_);
            if(_loc4_ >= 0)
            {
               var _loc2_:SongDataEntry = getSongDataEntry(_loc4_) as SongDataEntry;
            }
            _loc3_++;
         }
      }
      
      public function onSongLoaded(param1:int) : void
      {
         class_21.log("Song loaded : " + param1);
         var _loc2_:int = getTopRequestPriority();
         if(_loc2_ >= 0)
         {
            var _loc3_:int = getSongIdRequestedAtPriority(_loc2_);
            if(param1 == 0)
            {
               playSongObject(_loc2_,param1);
            }
         }
      }
      
      public function addSongInfoRequest(param1:int) : void
      {
         requestSong(param1,true);
      }
      
      public function requestSongInfoWithoutSamples(param1:int) : void
      {
         requestSong(param1,false);
      }
      
      private function requestSong(param1:int, param2:Boolean) : void
      {
         if(var_1097.getValue(param1) == null)
         {
            var_1097.add(param1,param2);
            var_1216.push(param1);
         }
      }
      
      public function getSongInfo(param1:int) : ISongInfo
      {
         var _loc2_:SongDataEntry = getSongDataEntry(param1);
         if(_loc2_ == null)
         {
            requestSongInfoWithoutSamples(param1);
         }
         return _loc2_;
      }
      
      public function requestUserSongDisks() : void
      {
         if(var_37 == null)
         {
            return;
         }
         var_37.send(new GetUserSongDisksMessageComposer());
      }
      
      public function getSongDiskInventorySize() : int
      {
         return var_711.length;
      }
      
      public function getSongDiskInventoryDiskId(param1:int) : int
      {
         if(param1 >= 0 && param1 < var_711.length)
         {
            return var_711.getKey(param1);
         }
         return -1;
      }
      
      public function getSongDiskInventorySongId(param1:int) : int
      {
         if(param1 >= 0 && param1 < var_711.length)
         {
            return var_711.getWithIndex(param1);
         }
         return -1;
      }
      
      public function getSongIdPlayingAtPriority(param1:int) : int
      {
         if(param1 != var_402)
         {
            return -1;
         }
         return var_2409;
      }
      
      public function samplesUnloaded(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc3_:SongDataEntry = null;
         var _loc4_:TraxSequencer = null;
         var _loc2_:Array = null;
         var _loc6_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < var_539.length)
         {
            _loc3_ = var_539.getWithIndex(_loc5_) as SongDataEntry;
            _loc4_ = _loc3_.soundObject as TraxSequencer;
            if(_loc3_.id != var_2409 && _loc4_ != null && _loc4_.ready)
            {
               _loc2_ = _loc4_.traxData.getSampleIds();
               _loc6_ = 0;
               while(_loc6_ < param1.length)
               {
                  if(_loc2_.indexOf(param1[_loc6_]) != -1)
                  {
                     _loc3_.soundObject = null;
                     _loc4_.dispose();
                     class_21.log("Unloaded " + _loc3_.name + " by " + _loc3_.creator);
                  }
                  _loc6_++;
               }
            }
            _loc5_++;
         }
      }
      
      public function get samplesIdsInUse() : Array
      {
         var _loc5_:int = 0;
         var _loc4_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < var_725.length)
         {
            if(var_725[_loc5_] != null)
            {
               var _loc3_:SongStartRequestData = var_725[_loc5_];
               var _loc2_:SongDataEntry = var_539.getValue(null.songId);
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function sendNextSongRequestMessage(param1:TimerEvent) : void
      {
         if(var_1216.length < 1)
         {
            return;
         }
         if(var_37 == null)
         {
            return;
         }
         var_37.send(new GetSongInfoMessageComposer(var_1216));
         class_21.log("Requested song info\'s : " + var_1216);
         var_1216 = [];
      }
      
      private function onSongInfoMessage(param1:IMessageEvent) : void
      {
         var _loc8_:int = 0;
         var _loc9_:class_3637 = null;
         var _loc10_:* = false;
         var _loc4_:Boolean = false;
         var _loc11_:class_1814 = null;
         var _loc12_:SongDataEntry = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:TraxSongInfoMessageEvent = param1 as TraxSongInfoMessageEvent;
         var _loc2_:TraxSongInfoMessageEventParser = _loc3_.getParser() as TraxSongInfoMessageEventParser;
         var _loc7_:Array = _loc2_.songs;
         _loc8_ = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc9_ = _loc7_[_loc8_];
            _loc10_ = getSongDataEntry(_loc9_.id) == null;
            _loc4_ = areSamplesRequested(_loc9_.id);
            if(_loc10_)
            {
               _loc11_ = null;
               if(_loc4_)
               {
                  _loc11_ = _soundManager.loadTraxSong(_loc9_.id,_loc9_.data);
               }
               _loc12_ = new SongDataEntry(_loc9_.id,_loc9_.length,_loc9_.name,_loc9_.creator,_loc11_);
               _loc12_.songData = _loc9_.data;
               var_539.add(_loc9_.id,_loc12_);
               _loc5_ = getTopRequestPriority();
               _loc6_ = getSongIdRequestedAtPriority(_loc5_);
               if(_loc11_ != null && _loc11_.ready && _loc9_.id == _loc6_)
               {
                  playSongObject(_loc5_,_loc6_);
               }
               name_1.dispatchEvent(new SongInfoReceivedEvent("SIR_TRAX_SONG_INFO_RECEIVED",_loc9_.id));
               while(var_1782.indexOf(_loc9_.id) != -1)
               {
                  var_1782.splice(var_1782.indexOf(_loc9_.id),1);
                  if(var_1782.length == 0)
                  {
                     name_1.dispatchEvent(new SongDiskInventoryReceivedEvent("SDIR_SONG_DISK_INVENTORY_RECEIVENT_EVENT"));
                  }
               }
               class_21.log("Received song info : " + _loc9_.id);
            }
            _loc8_++;
         }
      }
      
      private function playSongObject(param1:int, param2:int) : Boolean
      {
         if(param2 == -1 || param1 < 0 || param1 >= 4)
         {
            return false;
         }
         var _loc6_:Boolean = false;
         if(stopSongAtPriority(var_402))
         {
            _loc6_ = true;
         }
         var _loc5_:SongDataEntry = getSongDataEntry(param2);
         if(_loc5_ == null)
         {
            class_21.log("WARNING: Unable to find song entry id " + param2 + " that was supposed to be loaded.");
            return false;
         }
         var _loc3_:class_1814 = _loc5_.soundObject;
         if(_loc3_ == null || !_loc3_.ready)
         {
            return false;
         }
         if(_loc6_)
         {
            class_21.log("Waiting previous song to stop before playing song " + param2);
            return true;
         }
         _loc3_.volume = _soundManager.traxVolume;
         var _loc9_:Number = -1;
         var _loc7_:Number = 0;
         var _loc4_:Number = 2;
         var _loc8_:Number = 1;
         var _loc10_:SongStartRequestData = getSongStartRequest(param1);
         if(_loc10_ != null)
         {
            _loc9_ = _loc10_.startPos;
            _loc7_ = _loc10_.playLength;
            _loc4_ = _loc10_.fadeInSeconds;
            _loc8_ = _loc10_.fadeOutSeconds;
         }
         if(_loc9_ >= _loc5_.length / 1000)
         {
            return false;
         }
         if(_loc9_ == -1)
         {
            _loc9_ = 0;
         }
         _loc3_.fadeInSeconds = _loc4_;
         _loc3_.fadeOutSeconds = _loc8_;
         _loc3_.position = _loc9_;
         _loc3_.play(_loc7_);
         var_402 = param1;
         var_3123 = getSongRequestCountAtPriority(param1);
         var_2409 = param2;
         if(var_402 <= 0)
         {
            notifySongPlaying(_loc5_);
         }
         if(param1 > 0)
         {
            name_1.dispatchEvent(new NowPlayingEvent("NPE_USER_PLAY_SONG",param1,_loc5_.id,-1));
         }
         class_21.log("Started playing song " + param2 + " at position " + _loc9_ + " for " + _loc7_ + " seconds (length " + _loc5_.length / 1000 + ") with priority " + param1);
         return true;
      }
      
      private function notifySongPlaying(param1:SongDataEntry) : void
      {
         var _loc3_:int = getTimer();
         if(param1.length >= 8000 && (var_3826 != param1.id || _loc3_ > _previousNotificationTime + 8000))
         {
            _soundManager.notifyPlayedSong(param1.name,param1.creator);
            var_3826 = param1.id;
            _previousNotificationTime = _loc3_;
         }
      }
      
      private function areSamplesRequested(param1:int) : Boolean
      {
         if(var_1097.getValue(param1) == null)
         {
            return false;
         }
         return var_1097.getValue(param1);
      }
      
      private function onSongDiskInventoryMessage(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:UserSongDisksInventoryMessageEvent = param1 as UserSongDisksInventoryMessageEvent;
         var _loc2_:UserSongDisksInventoryMessageEventParser = _loc3_.getParser() as UserSongDisksInventoryMessageEventParser;
         var_711.reset();
         _loc4_ = 0;
         while(_loc4_ < _loc2_.songDiskCount)
         {
            _loc5_ = _loc2_.getDiskId(_loc4_);
            _loc6_ = _loc2_.getSongId(_loc4_);
            var_711.add(_loc5_,_loc6_);
            if(var_539.getValue(_loc6_) == null)
            {
               var_1782.push(_loc6_);
               requestSongInfoWithoutSamples(_loc6_);
            }
            _loc4_++;
         }
         if(var_1782.length == 0)
         {
            name_1.dispatchEvent(new SongDiskInventoryReceivedEvent("SDIR_SONG_DISK_INVENTORY_RECEIVENT_EVENT"));
         }
      }
      
      private function onSoundMachineInit(param1:Event) : void
      {
         disposeRoomPlaylist();
         var_692 = new SoundMachinePlayListController(_soundManager,this,name_1,_roomEvents,var_37) as class_3073;
      }
      
      private function onSoundMachineDispose(param1:Event) : void
      {
         disposeRoomPlaylist();
      }
      
      private function onJukeboxInit(param1:Event) : void
      {
         disposeRoomPlaylist();
         var_692 = new JukeboxPlayListController(_soundManager,this,name_1,var_37) as class_3073;
         var_37.send(new GetNowPlayingMessageComposer());
      }
      
      private function onJukeboxDispose(param1:Event) : void
      {
         disposeRoomPlaylist();
      }
      
      private function disposeRoomPlaylist() : void
      {
         if(var_692 != null)
         {
            var_692.dispose();
            var_692 = null;
         }
      }
   }
}

