let currentInput = '0';
let previousInput = '';
let operation = null;
let resetInput = false;

const expressionDisplay = document.getElementById('expression');
const resultDisplay = document.getElementById('result');

function updateDisplay() {
    if (operation && previousInput) {
        expressionDisplay.value = `${previousInput} ${operation} ${currentInput}`;
    } else {
        expressionDisplay.value = '';
    }
    resultDisplay.value = currentInput;
}

function appendNumber(number) {
    if (currentInput === '0' || resetInput) {
        currentInput = number;
        resetInput = false;
    } else {
        currentInput += number;
    }
    updateDisplay();
}

function appendDecimal() {
    if (resetInput) {
        currentInput = '0.';
        resetInput = false;
    } else if (!currentInput.includes('.')) {
        currentInput += '.';
    }
    updateDisplay();
}

function appendOperator(op) {
    if (operation !== null) calculate();
    previousInput = currentInput;
    operation = op;
    resetInput = true;
}

function calculate() {
    let computation;
    const prev = parseFloat(previousInput);
    const current = parseFloat(currentInput);
    
    if (isNaN(prev)) return;
    
    switch (operation) {
        case '+':
            computation = prev + current;
            break;
        case '-':
            computation = prev - current;
            break;
        case '*':
            computation = prev * current;
            break;
        case '/':
            computation = prev / current;
            break;
        default:
            return;
    }
    
    expressionDisplay.value = `${previousInput} ${operation} ${currentInput} =`;
    currentInput = computation.toString();
    resultDisplay.value = currentInput;
    previousInput = '';
    operation = null;
    resetInput = true;
}

function appendOperator(op) {
    if (operation !== null) {
        calculate();
    }
    previousInput = currentInput;
    operation = op;
    currentInput = '0';  
    updateDisplay();
}

function clearDisplay() {
    currentInput = '0';
    previousInput = '';
    operation = null;
    expressionDisplay.value = '';
    resultDisplay.value = '0';
}


updateDisplay();