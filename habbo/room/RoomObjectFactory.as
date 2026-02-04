package com.sulake.habbo.room
{
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.room.object.logic.AvatarLogic;
   import com.sulake.habbo.room.object.logic.PetLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureClothingChangeLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureCreditLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureCuckooClockLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureDiceLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureEcotronBoxLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureExternalImageLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureFireworksLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureGuildCustomizedLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureHabboWheelLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureHockeyScoreLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureJukeboxLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureMannequinLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureMultiHeightLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureMultiStateLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureMysteryTrophyLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureNftCreditLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureNftRewardBoxLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureOneWayDoorLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurniturePetProductLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurniturePlaceholderLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurniturePlanetSystemLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurniturePresentLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurniturePushableLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureRandomStateLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomBackgroundLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomBillboardLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureSongDiskLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureSoundMachineLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureStickieLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureTrophyLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureWelcomeGiftLogic;
   import com.sulake.habbo.room.object.logic.furniture.class_1738;
   import com.sulake.habbo.room.object.logic.furniture.class_1759;
   import com.sulake.habbo.room.object.logic.furniture.class_1778;
   import com.sulake.habbo.room.object.logic.furniture.class_1794;
   import com.sulake.habbo.room.object.logic.furniture.class_1837;
   import com.sulake.habbo.room.object.logic.furniture.class_1868;
   import com.sulake.habbo.room.object.logic.furniture.class_1872;
   import com.sulake.habbo.room.object.logic.furniture.class_1883;
   import com.sulake.habbo.room.object.logic.furniture.class_1887;
   import com.sulake.habbo.room.object.logic.furniture.class_1905;
   import com.sulake.habbo.room.object.logic.furniture.class_1908;
   import com.sulake.habbo.room.object.logic.furniture.class_1909;
   import com.sulake.habbo.room.object.logic.furniture.class_1930;
   import com.sulake.habbo.room.object.logic.furniture.class_1975;
   import com.sulake.habbo.room.object.logic.furniture.class_1978;
   import com.sulake.habbo.room.object.logic.furniture.class_1983;
   import com.sulake.habbo.room.object.logic.furniture.class_1990;
   import com.sulake.habbo.room.object.logic.furniture.class_2016;
   import com.sulake.habbo.room.object.logic.furniture.class_2033;
   import com.sulake.habbo.room.object.logic.furniture.class_2043;
   import com.sulake.habbo.room.object.logic.furniture.class_2046;
   import com.sulake.habbo.room.object.logic.furniture.class_2058;
   import com.sulake.habbo.room.object.logic.furniture.class_2065;
   import com.sulake.habbo.room.object.logic.furniture.class_2068;
   import com.sulake.habbo.room.object.logic.furniture.class_2072;
   import com.sulake.habbo.room.object.logic.furniture.class_2087;
   import com.sulake.habbo.room.object.logic.furniture.class_2132;
   import com.sulake.habbo.room.object.logic.furniture.class_2136;
   import com.sulake.habbo.room.object.logic.furniture.class_2191;
   import com.sulake.habbo.room.object.logic.furniture.class_2220;
   import com.sulake.habbo.room.object.logic.furniture.class_2225;
   import com.sulake.habbo.room.object.logic.furniture.class_2241;
   import com.sulake.habbo.room.object.logic.furniture.class_2246;
   import com.sulake.habbo.room.object.logic.furniture.class_2252;
   import com.sulake.habbo.room.object.logic.game.SnowballLogic;
   import com.sulake.habbo.room.object.logic.game.class_1882;
   import com.sulake.habbo.room.object.logic.room.RoomLogic;
   import com.sulake.habbo.room.object.logic.room.RoomTileCursorLogic;
   import com.sulake.habbo.room.object.logic.room.SelectionArrowLogic;
   import com.sulake.room.IRoomObjectFactory;
   import com.sulake.room.IRoomObjectManager;
   import com.sulake.room.RoomObjectManager;
   import com.sulake.room.object.logic.IRoomObjectEventHandler;
   
   public class RoomObjectFactory extends class_17 implements IRoomObjectFactory
   {
      
      private var var_3682:class_55 = new class_55();
      
      private var var_2513:class_55 = new class_55();
      
      private var _objectEventListeners:Array = [];
      
      public function RoomObjectFactory(param1:class_15, param2:uint = 0)
      {
         super(param1,param2);
      }
      
      public function addObjectEventListener(param1:Function) : void
      {
         if(_objectEventListeners.indexOf(param1) < 0)
         {
            _objectEventListeners.push(param1);
            if(param1 != null)
            {
               for each(var _loc2_ in var_2513.getKeys())
               {
                  events.addEventListener(null,param1);
               }
            }
         }
      }
      
      public function removeObjectEventListener(param1:Function) : void
      {
         var _loc2_:int = int(_objectEventListeners.indexOf(param1));
         if(_loc2_ >= 0)
         {
            _objectEventListeners.splice(_loc2_,1);
            if(param1 != null)
            {
               for each(var _loc3_ in var_2513.getKeys())
               {
                  events.removeEventListener(null,param1);
               }
            }
         }
      }
      
      private function addTrackedEventType(param1:String) : void
      {
         if(var_2513.getValue(param1) == null)
         {
            var_2513.add(param1,true);
            for each(var _loc2_ in _objectEventListeners)
            {
               if(_loc2_ != null)
               {
                  events.addEventListener(param1,_loc2_);
               }
            }
         }
      }
      
      public function createRoomObjectLogic(param1:String) : IRoomObjectEventHandler
      {
         var _loc6_:IRoomObjectEventHandler = null;
         var _loc3_:Class = null;
         switch(param1)
         {
            case "furniture_basic":
               _loc3_ = class_1738;
               break;
            case "furniture_multistate":
               _loc3_ = FurnitureMultiStateLogic;
               break;
            case "furniture_multiheight":
               _loc3_ = FurnitureMultiHeightLogic;
               break;
            case "furniture_placeholder":
               _loc3_ = FurniturePlaceholderLogic;
               break;
            case "user":
            case "bot":
            case "rentable_bot":
               _loc3_ = AvatarLogic;
               break;
            case "pet":
               _loc3_ = PetLogic;
               break;
            case "furniture_randomstate":
               _loc3_ = FurnitureRandomStateLogic;
               break;
            case "furniture_credit":
               _loc3_ = FurnitureCreditLogic;
               break;
            case "furniture_stickie":
               _loc3_ = FurnitureStickieLogic;
               break;
            case "furniture_external_image_wallitem":
               _loc3_ = FurnitureExternalImageLogic;
               break;
            case "furniture_present":
               _loc3_ = FurniturePresentLogic;
               break;
            case "furniture_trophy":
               _loc3_ = FurnitureTrophyLogic;
               break;
            case "furniture_ecotron_box":
               _loc3_ = FurnitureEcotronBoxLogic;
               break;
            case "furniture_dice":
               _loc3_ = FurnitureDiceLogic;
               break;
            case "furniture_hockey_score":
               _loc3_ = FurnitureHockeyScoreLogic;
               break;
            case "furniture_habbowheel":
               _loc3_ = FurnitureHabboWheelLogic;
               break;
            case "furniture_one_way_door":
               _loc3_ = FurnitureOneWayDoorLogic;
               break;
            case "furniture_planet_system":
               _loc3_ = FurniturePlanetSystemLogic;
               break;
            case "furniture_window":
               _loc3_ = class_1983;
               break;
            case "furniture_roomdimmer":
               _loc3_ = class_1759;
               break;
            case "tile_cursor":
               _loc3_ = RoomTileCursorLogic;
               break;
            case "selection_arrow":
               _loc3_ = SelectionArrowLogic;
               break;
            case "furniture_sound_machine":
               _loc3_ = FurnitureSoundMachineLogic;
               break;
            case "furniture_jukebox":
               _loc3_ = FurnitureJukeboxLogic;
               break;
            case "furniture_crackable":
               _loc3_ = class_1887;
               break;
            case "furniture_song_disk":
               _loc3_ = FurnitureSongDiskLogic;
               break;
            case "furniture_pushable":
               _loc3_ = FurniturePushableLogic;
               break;
            case "furniture_clothing_change":
               _loc3_ = FurnitureClothingChangeLogic;
               break;
            case "furniture_counter_clock":
               _loc3_ = class_2191;
               break;
            case "furniture_score":
               _loc3_ = class_2241;
               break;
            case "furniture_es":
               _loc3_ = class_2087;
               break;
            case "furniture_fireworks":
               _loc3_ = FurnitureFireworksLogic;
               break;
            case "furniture_bb":
               _loc3_ = FurnitureRoomBillboardLogic;
               break;
            case "furniture_bg":
               _loc3_ = FurnitureRoomBackgroundLogic;
               break;
            case "furniture_welcome_gift":
               _loc3_ = FurnitureWelcomeGiftLogic;
               break;
            case "furniture_floor_hole":
               _loc3_ = class_2132;
               break;
            case "room":
               _loc3_ = RoomLogic;
               break;
            case "furniture_mannequin":
               _loc3_ = FurnitureMannequinLogic;
               break;
            case "furniture_guild_customized":
               _loc3_ = FurnitureGuildCustomizedLogic;
               break;
            case "furniture_group_forum_terminal":
               _loc3_ = class_1905;
               break;
            case "furniture_pet_customization":
               _loc3_ = FurniturePetProductLogic;
               break;
            case "game_snowball":
               _loc3_ = SnowballLogic;
               break;
            case "game_snowsplash":
               _loc3_ = class_1882;
               break;
            case "furniture_cuckoo_clock":
               _loc3_ = FurnitureCuckooClockLogic;
               break;
            case "furniture_vote_counter":
               _loc3_ = class_2136;
               break;
            case "furniture_vote_majority":
               _loc3_ = class_2068;
               break;
            case "furniture_soundblock":
               _loc3_ = class_2033;
               break;
            case "furniture_random_teleport":
               _loc3_ = class_2043;
               break;
            case "furniture_monsterplant_seed":
               _loc3_ = class_1990;
               break;
            case "furniture_purchasable_clothing":
               _loc3_ = class_1837;
               break;
            case "furniture_background_color":
               _loc3_ = class_2046;
               break;
            case "furniture_area_hide":
               _loc3_ = class_1794;
               break;
            case "furniture_mysterybox":
               _loc3_ = class_1872;
               break;
            case "furniture_effectbox":
               _loc3_ = class_1868;
               break;
            case "furniture_mysterytrophy":
               _loc3_ = FurnitureMysteryTrophyLogic;
               break;
            case "furniture_achievement_resolution":
               _loc3_ = class_1909;
               break;
            case "furniture_lovelock":
               _loc3_ = class_2065;
               break;
            case "furniture_wildwest_wanted":
               _loc3_ = class_1930;
               break;
            case "furniture_hween_lovelock":
               _loc3_ = class_2252;
               break;
            case "furniture_badge_display":
               _loc3_ = class_1908;
               break;
            case "furniture_high_score":
               _loc3_ = class_1975;
               break;
            case "furniture_internal_link":
               _loc3_ = class_2016;
               break;
            case "furniture_editable_internal_link":
               _loc3_ = class_1778;
               break;
            case "furniture_editable_room_link":
               _loc3_ = class_1883;
               break;
            case "furniture_custom_stack_height":
               _loc3_ = class_1978;
               break;
            case "furniture_youtube":
               _loc3_ = class_2246;
               break;
            case "furniture_rentable_space":
               _loc3_ = class_2225;
               break;
            case "furniture_change_state_when_step_on":
               _loc3_ = class_2220;
               break;
            case "furniture_vimeo":
               _loc3_ = class_2058;
               break;
            case "furniture_crafting_gizmo":
               _loc3_ = class_2072;
               break;
            case "furniture_nft_credit":
               _loc3_ = FurnitureNftCreditLogic;
               break;
            case "furniture_nft_reward_box":
               _loc3_ = FurnitureNftRewardBoxLogic;
         }
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:Object = new _loc3_();
         if(_loc4_ is IRoomObjectEventHandler)
         {
            _loc6_ = _loc4_ as IRoomObjectEventHandler;
            _loc6_.eventDispatcher = this.events;
            if(var_3682.getValue(param1) == null)
            {
               var_3682.add(param1,true);
               var _loc2_:Array = _loc6_.getEventTypes();
               for each(var _loc5_ in null)
               {
                  addTrackedEventType(_loc5_);
               }
            }
            return _loc6_;
         }
         return null;
      }
      
      public function createRoomObjectManager() : IRoomObjectManager
      {
         return new RoomObjectManager();
      }
   }
}

