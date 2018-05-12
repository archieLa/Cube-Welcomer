import board
import digitalio
import time

class PresenceSensor:
    def _init_(self):
        self.objectDetected = digitalio.DigitalInOut(board.D11)
        self.objectDetected.direction = digitalio.Direction.INPUT
    def checkPresence(self):
        return self.objectDetected.value
                
class SmileySpeakerOutput:
    def _init_(self):
        self.speakerOn = digitalio.DigitalInOut(board.D12)
        self.speakerOn.direction = digitalio.Direction.OUTPUT
        self.smileyOn = digitalio.DigitalInOut(board.D13)
        self.smileyOn.direction = digitalio.Direction.OUTPUT
        self.onDelay = 0.5
    def trigger(self):
        speakerOn.value = True
        smileyOn.value = True
        time.sleep(self.onDelay)
        speakerOn.value = False
        smileyOn.value = False

class CubeWelcomer:
    def _init_(self):
        self.smiley_speaker = SmileySpeakerOutput()
        self.object_in_view = False
    def toGreetOrNotToGreet(self, objectPresent):
        if (self.object_in_view == False and
        objectPresent == True):
            SmileySpeakerOutput.trigger()
            self.object_in_view = True
        elif (self.object_in_view == True and
        objectPresent == False):
            self.object_in_view = False   
    
cubeWelcomer = CubeWelcomer()
presenceSensor = PresenceSensor()

while True:
    cubeWelcomer.toGreetOrNotToGreet(presenceSensor.checkPresence)
    time.sleep(0.25)
    