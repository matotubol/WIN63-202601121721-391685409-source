package com.sulake.habbo.freeflowchat.viewer.simulation
{
   public class ChatBubbleCollisionEvent
   {
      
      private var var_561:ChatBubbleSimulationEntity;
      
      private var var_554:ChatBubbleSimulationEntity;
      
      public function ChatBubbleCollisionEvent(param1:ChatBubbleSimulationEntity, param2:ChatBubbleSimulationEntity)
      {
         super();
         var_561 = param1;
         var_554 = param2;
      }
      
      public function get first() : ChatBubbleSimulationEntity
      {
         return var_561;
      }
      
      public function get second() : ChatBubbleSimulationEntity
      {
         return var_554;
      }
      
      public function get top() : ChatBubbleSimulationEntity
      {
         return var_561.y < var_554.y ? var_561 : var_554;
      }
      
      public function get bottom() : ChatBubbleSimulationEntity
      {
         return var_561.y >= var_554.y ? var_561 : var_554;
      }
      
      public function get left() : ChatBubbleSimulationEntity
      {
         return var_561.x < var_554.x ? var_561 : var_554;
      }
      
      public function get right() : ChatBubbleSimulationEntity
      {
         return var_561.x >= var_554.x ? var_561 : var_554;
      }
      
      public function get areSameY() : Boolean
      {
         return int(var_561.y) == int(var_554.y);
      }
      
      public function get older() : ChatBubbleSimulationEntity
      {
         return var_561.timeStamp < var_554.timeStamp ? var_561 : var_554;
      }
   }
}

