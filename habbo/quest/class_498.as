package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface class_498 extends IUnknown
   {
      
      function ensureAchievementsInitialized() : void;
      
      function showAchievements() : void;
      
      function showQuests() : void;
      
      function getAchievementLevel(param1:String, param2:String) : int;
      
      function reenableRoomCompetitionWindow() : void;
      
      function requestSeasonalQuests() : void;
      
      function requestQuests() : void;
      
      function get events() : IEventDispatcher;
      
      function activateQuest(param1:int) : void;
      
      function goToQuestRooms() : void;
   }
}

