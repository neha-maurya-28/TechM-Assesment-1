document.addEventListener('DOMContentLoaded', () => {
    const display = document.getElementById('display');
    const minutesInput = document.getElementById('minutes');
    const secondsInput = document.getElementById('seconds');
    const startBtn = document.getElementById('startBtn');
    const pauseBtn = document.getElementById('pauseBtn');
    const resetBtn = document.getElementById('resetBtn');
    
    let countdown;
    let totalSeconds = 0;
    let isRunning = false;
    let remainingSeconds = 0;

    function formatTime(seconds) {
        const mins = Math.floor(seconds / 60);
        const secs = seconds % 60;
        return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
    }

    function updateDisplay() {
        display.textContent = formatTime(remainingSeconds);
    }

    function startTimer() {
        if (isRunning) return;
        
        if (remainingSeconds <= 0) {
            const mins = parseInt(minutesInput.value) || 0;
            const secs = parseInt(secondsInput.value) || 0;
            totalSeconds = mins * 60 + secs;
            remainingSeconds = totalSeconds;
            
            if (remainingSeconds <= 0) {
                alert('Please set a valid time!');
                return;
            }
        }
        
        isRunning = true;
        startBtn.disabled = true;
        pauseBtn.disabled = false;
        
        countdown = setInterval(() => {
            remainingSeconds--;
            updateDisplay();
            
            if (remainingSeconds <= 0) {
                clearInterval(countdown);
                isRunning = false;
                startBtn.disabled = false;
                pauseBtn.disabled = true;
                alert('Time is up!');
            }
        }, 1000);
    }

    function pauseTimer() {
        clearInterval(countdown);
        isRunning = false;
        startBtn.disabled = false;
        pauseBtn.disabled = true;
    }

    function resetTimer() {
        clearInterval(countdown);
        isRunning = false;
        remainingSeconds = 0;
        minutesInput.value = '0';
        secondsInput.value = '0';
        updateDisplay();
        startBtn.disabled = false;
        pauseBtn.disabled = true;
    }

   
    startBtn.addEventListener('click', startTimer);
    pauseBtn.addEventListener('click', pauseTimer);
    resetBtn.addEventListener('click', resetTimer);
    
    pauseBtn.disabled = true;
    updateDisplay();
    
    minutesInput.addEventListener('change', () => {
        let value = parseInt(minutesInput.value);
        if (isNaN(value) || value < 0) minutesInput.value = '0';
        if (value > 59) minutesInput.value = '59';
    });
    
    secondsInput.addEventListener('change', () => {
        let value = parseInt(secondsInput.value);
        if (isNaN(value) || value < 0) secondsInput.value = '0';
        if (value > 59) secondsInput.value = '59';
    });
});