import board
import digitalio
import time

class PresenceSensor:
    def _init_(self):
        self.objectDetected = digitalio.DigitalInOut(board.D11)
        self.objectDetected.direction = digitalio.Direction.INPUT
    def checkPresenece(self):
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

class Program:
    def _init_(self):
        self.smiley_speaker = SmileySpeakerOutput()
        self.presence_sensor = PresenceSensor()
        self.trigger_state = "NotYetTriggered"
        self.object_present_previous = "NotPresent"
    def determineState(self, objectDetected):
        #TODO determine current state
    def executeState(self, state):
        #TODO how to execute specific state
    def start(self):
        while True:
            executeState(determineState(self.presenceSensor.checkPresence()))
            #maybe put some delay here
     
program = DetectionProgram()
app.start()

    